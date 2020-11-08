import Redis
import NIO

func main() throws {
    let config = try RedisConfiguration(hostname: "localhost",
                                        port: 6379,
                                        pool: .init(connectionRetryTimeout: .minutes(1)))

    let redisClient = SimpleRedisClient(configuration: config,
                                  eventLoopGroup: MultiThreadedEventLoopGroup(numberOfThreads: 1))
    
    let result = redisClient.brpop(from: RedisKey("salutations"), timeout: TimeAmount.seconds(300))
        .map { print($0.string!) }
    
    try result.wait()
    try redisClient.shutdown()
}

struct SimpleRedisClient: RedisClient {
    let configuration: RedisConfiguration
    let eventLoopGroup: EventLoopGroup
    let connection: RedisConnectionPool
    
    init(configuration: RedisConfiguration, eventLoopGroup: EventLoopGroup) {
        self.configuration = configuration
        self.eventLoopGroup = eventLoopGroup
        
        connection = RedisConnectionPool(
            serverConnectionAddresses: configuration.serverAddresses,
            loop: eventLoopGroup.next(),
            maximumConnectionCount: configuration.pool.maximumConnectionCount
        )
    }

    func send(command: String, with arguments: [RESPValue]) -> EventLoopFuture<RESPValue> {
        connection.send(command: command, with: arguments)
    }

    public var eventLoop: EventLoop {
        self.eventLoopGroup.next()
    }

    public func logging(to logger: Logger) -> RedisClient {
        self
    }

    func unsubscribe(from channels: [RedisChannelName]) -> EventLoopFuture<Void> {
        eventLoop.future()
    }

    func punsubscribe(from patterns: [String]) -> EventLoopFuture<Void> {
        eventLoop.future()
    }
    
    func shutdown() throws {
        let whenConnectionCloses: EventLoopPromise<Void> = eventLoop.makePromise()
        connection.close(promise: whenConnectionCloses)
        
        try whenConnectionCloses.futureResult.wait()
        try eventLoopGroup.syncShutdownGracefully()
    }
}

try main()
