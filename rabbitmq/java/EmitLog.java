import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.MessageProperties;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.Channel;
import java.nio.charset.StandardCharsets;
public class EmitLog {
    private final static String EXCHANGE_NAME = "logs";

    public static void main(String[] args) throws Exception {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost("localhost");
        factory.setUsername("user");
        factory.setPassword("password");
        try(
            Connection connection = factory.newConnection();
            Channel channel = connection.createChannel()){
                channel.exchangeDeclare(EXCHANGE_NAME, "fanout", true);
                for (int i = 0; i < 5 ; i++){
                    String message = String.format("Log message %d", i);
                    channel.basicPublish(EXCHANGE_NAME, "", null, message.getBytes(StandardCharsets.UTF_8));
                    System.out.println("[x] Sent '" + message + "'");
                }
                
                System.out.println("[x] Sent complete");    
            }
    }
}