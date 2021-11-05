import java.io.*;
import java.net.Socket;
import java.nio.Buffer;
import java.util.Scanner;

public class Client {
    private Socket socket;
    private BufferedReader bufferedReader;
    private BufferedWriter bufferedWriter;
    private String username;
    private String chatRoom;

    public Client(Socket socket, String Username, String ChatRoom){
        try{
            this.socket = socket;
            this.bufferedWriter = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
            this.bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            this.username = Username;
            this.chatRoom = ChatRoom;

        } catch (IOException e) {
            closeEverything(socket, bufferedWriter, bufferedReader);
        }
    }
    public void sendMessage(){
        try{
            bufferedWriter.write(username);
            bufferedWriter.newLine();

            bufferedWriter.write(chatRoom);
            bufferedWriter.newLine();
            bufferedWriter.flush();

            Scanner scanner = new Scanner(System.in);
            while(socket.isConnected()){
                String messageToSend = scanner.nextLine();
                bufferedWriter.write(messageToSend + " - " + username);
                bufferedWriter.newLine();
                bufferedWriter.flush();

            }
        } catch (IOException e) {
            closeEverything(socket, bufferedWriter, bufferedReader);
        }
    }

    public void sendMessageNew(String msg) {
        print(msg + " sent");
        try {
            //bufferedWriter.write(username + "\n");
            //bufferedWriter.write(chatRoom + "\n");
            //bufferedWriter.flush();
            
     
            if (socket.isConnected()) {
              
                bufferedWriter.write(msg + " - " + username);
                bufferedWriter.newLine();
                bufferedWriter.flush();
                
            }
        } catch (IOException e) {
            closeEverything(socket, bufferedWriter, bufferedReader);
        }
    }

    public void listenForMessage() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                String messageFromGroupChat;
                while (socket.isConnected()){
                    println("Is Connected");
                    try {
                        messageFromGroupChat = bufferedReader.readLine();
                        println(messageFromGroupChat);
                        //System.out.println(messageFromGroupChat);
                        if(pages[2] instanceof ChatPage) ((ChatPage)pages[2]).getChat().receiveMessage(messageFromGroupChat, false);
                        
                    } catch (IOException e) {
                        closeEverything(socket, bufferedWriter, bufferedReader);
                    }
                }
            }
        }).start();
    }

    public  void closeEverything(Socket socket, BufferedWriter bufferedWriter, BufferedReader bufferedReader){
        try {
            if(bufferedWriter != null){ //here we check if bufferedReader is not equal to null in order to avoid null-pointer-exception.
                bufferedReader.close();
            }
            if(bufferedReader != null){ //here we check if bufferedWriter is not equal to null in order to avoid null-pointer-exception.
                bufferedWriter.close();
            }

            if(socket != null){ //here we check if socket is not equal to null in order to avoid null-pointer-exception.
                socket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
    
    public void sendInformation() {
      try {
        bufferedWriter.write(username + "\n");
        bufferedWriter.write(chatRoom + "\n");
        bufferedWriter.flush();    
        
        } catch (IOException e) {
            closeEverything(socket, bufferedWriter, bufferedReader);
        }
    }
}
