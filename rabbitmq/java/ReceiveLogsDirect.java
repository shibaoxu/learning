import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.DeliverCallback;

public class ReceiveLogsDirect {
    private final static String EXCHANGE_NAME = "logs_direct";

    public static void main(String[] args) throws Exception {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost("localhost");
        factory.setUsername("user");
        factory.setPassword("password");
        Connection connection = factory.newConnection();
        Channel channel = connection.createChannel();
        boolean durable = true;

        channel.exchangeDeclare(EXCHANGE_NAME, "direct", durable);
        String queueName = args[0];
        String routeKey = args[1];
        channel.queueDeclare(queueName, durable, false, false, null);
        channel.queueBind(queueName, EXCHANGE_NAME, routeKey);

        System.out.println("[x] Wating for message. To exit press CTRL+C");

        // channel.basicQos(1);
        DeliverCallback deliverCallback = (consumerTag, delivery) -> {
            String message = new String(delivery.getBody(), "UTF-8");
            System.out.println("[x] Received '" + message + "'");

            try {
                doWork(message);
            } finally {
                System.out.println("[x] Done");
                // channel.basicAck(delivery.getEnvelope().getDeliveryTag(), false);
            }
        };

        boolean autoAck = true;
        channel.basicConsume(queueName, autoAck, deliverCallback, consumerTag -> {
        });
    }

    private static void doWork(String task) {
        for (char ch : task.toCharArray()) {
            if (ch == '.') {
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException _ignore) {
                    Thread.currentThread().interrupt();
                }
            }
        }
    }
}