import java.io.*;
import java.net.Socket;
import java.util.ArrayList;

public class ClientHandler implements Runnable{
    public static ArrayList<ClientHandler> clientHandlers = new ArrayList<>(); //this list will keep track of all our clients, that is why it is static.
    public static ArrayList<String> chatroom_List = new ArrayList<String>();
    private Socket socket;

    //There are two types of streams byte streams and character streams, if a method or whatever ends on "stream" it is a byte-stream, if it ends on "Reader/Writer" it is a character stream.
    //This makes these two streams character streams.
    private BufferedReader bufferedReader;
    private BufferedWriter bufferedWriter;


    private String clientUsername;
    private String clientChatroom;

    public ClientHandler(Socket socket){
        try {
            this.socket = socket;
            this.bufferedWriter = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream())); //here we wrap our output byte-stream in a character stream. We also use a bufferedWriter to make it more efficient.
            this.bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream())); // here we do the same, just with an input-stream.
            this.clientUsername = bufferedReader.readLine(); //this reads what a client types until they press enter, because that will mean they have changed line hence "readLine".
            this.clientChatroom = bufferedReader.readLine();
            addToArray();

            clientHandlers.add(this); //this adds a ClientHandler object to the ArrayList.
            broadcastMessage("Server " + clientUsername + " has entered the chat! " + "(" + clientChatroom + ")");
        } catch (IOException e) {
            closeEverything(socket, bufferedReader, bufferedWriter); //this is done in order to avoid nested try/catch.
        }

    }


    public void addToArray() {
        if (!ClientHandler.chatroom_List.equals(clientChatroom)) {
            ClientHandler.chatroom_List.add(this.clientChatroom);

            System.out.println(chatroom_List);
        }
    }

    @Override
    public void run() {
        String messageFromClient;
        while (socket.isConnected()){
            try{
                messageFromClient = bufferedReader.readLine(); //program will halt here until it receives a message, that is why it is run on a separate thread (the run method).
                broadcastMessage(messageFromClient);

            } catch (IOException e) {
                closeEverything(socket, bufferedReader, bufferedWriter); //this is done in order to avoid nested try/catch.
                break; //when the client disconnect break the loop, which will result in the thread being shut down.
            }
        }

    }

    public  void broadcastMessage(String messageToSend){
        for(ClientHandler clientHandler : clientHandlers) { //shortcut for saying: for each clientHandler object in our ArrayList.
            try{
                if(!clientHandler.clientUsername.equals(clientUsername) && clientHandler.clientChatroom.equals(clientChatroom)){ //If clientHandler object is not equal to the current clientHandler object in the Array.
                    clientHandler.bufferedWriter.write(messageToSend); // Send message to that current clientHandler object in the Array.
                    clientHandler.bufferedWriter.newLine(); //this is needed because the client will use a "readLine", but since the server cant "press the enter key" like a human, we will have to emulate that with this with "newLine".
                    clientHandler.bufferedWriter.flush(); // a buffer wont send a message unless it is full, and our message will highly likely not fill up our buffer. we therefore prematurely tell our buffer that it is full by using "flush".
                }
            } catch (IOException e) {
                closeEverything(socket, bufferedReader, bufferedWriter); //this is done in order to avoid nested try/catch.
            }

        }

    }

    public void removeClientHandler(){
        clientHandlers.remove(this); //removes clientHandler object from ArrayList
        broadcastMessage("Server: " + clientUsername + " has left the chat");
    }

    public void closeEverything(Socket socket, BufferedReader bufferedReader, BufferedWriter bufferedWriter){
        removeClientHandler();
        try {
            if(bufferedReader != null){ //here we check if bufferedReader is not equal to null in order to avoid null-pointer-exception.
                bufferedReader.close();
            }
            if(bufferedWriter != null){ //here we check if bufferedWriter is not equal to null in order to avoid null-pointer-exception.
                bufferedWriter.close();
            }

            if(socket != null){ //here we check if socket is not equal to null in order to avoid null-pointer-exception.
                socket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
