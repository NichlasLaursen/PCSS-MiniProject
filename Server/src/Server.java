import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    private ServerSocket serverSocket;

    public Server(ServerSocket serverSocket) { //ServerSocket constructor.
        this.serverSocket = serverSocket;
    }

    public void startServer(){
        try{
            while(!serverSocket.isClosed()){ //While the ServerSocket is not closed.
                Socket socket = serverSocket.accept(); //Our program will halt here until a client is accepted. (When client connects a Socket object is returned)
                System.out.println("A new client has connected");
                ClientHandler clientHandler = new ClientHandler(socket); //this object is responsible for communicating with the client. Each client object will be handled by a separate thread

                Thread thread = new Thread(clientHandler); //ClientHandler implements runnable, which means that whatever is in the objects run method will be executed on its own thread.
                thread.start();
            }
        } catch (IOException e){

        }

    }


    public void closedServerSocket(){ //this method is created to avoid nested try/catch.
        try{
            if(serverSocket != null) { //here we check if serverSocket is not equal to null in order to avoid null-pointer-exception.
                serverSocket.close();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(8000); //Server will be listening for clients here.
        Server server = new Server(serverSocket); //takes the connected serverSocket as argument for the Server class constructor.
        server.startServer();

    }

}
