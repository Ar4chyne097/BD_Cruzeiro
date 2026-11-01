package connection;

import java.util.Scanner;
import java.sql.ResultSet;
import java.sql.Connection;
import java.util.ArrayList;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class funcoes {
    private String link = "jdbc:mysql://localhost:3306/db_regioes";
    private String user = "root";
    private String password = "";
    Connection conn = null;
    Scanner sc = new Scanner(System.in);
    
    public Connection abrir(){
        try{
            conn = DriverManager.getConnection(link, user, password);
            System.out.println("Conexão aberta e firmada.");
        }catch(SQLException e){
            System.out.println("Erro ao conectar! Tente novamente.");
            throw new RuntimeException(e);
        }
        return conn;
    }
    
    public Connection fechar(){
        if(conn != null){
            try {
                conn.close();
                System.out.println("A conexão foi encerrada!");
            } catch (SQLException e) {
                System.out.println("Houve um erro ao cessar a conexão!");
                throw new RuntimeException(e);
            }
        }
        return conn;
    }
    
    public void create(int numero, String nome, String tipo1, String tipo2){
        String comando = "insert into iniciais(id_pk, nome, tipo1, tipo2) values (?,?,?,?)";
        
        try(
            Connection conn = abrir();
            PreparedStatement stmt = conn.prepareStatement(comando);  
        ){  
            stmt.setInt(1, numero);
            stmt.setString(2, nome);
            stmt.setString(3, tipo1);
            
            if(tipo2 != null){
                stmt.setString(4, tipo2);
            }
            
            stmt.execute();
        } catch (SQLException e) {
            System.out.println("ERRO! Tente novamente.");
            throw new RuntimeException(e);
        }
    }
    
    public String read(int numero){
        String comando = "select * from iniciais where id_pk = ?";
        try(
            Connection conn = abrir();
            PreparedStatement stmt = conn.prepareStatement(comando);
        ){
            stmt.setInt(1, numero);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                int número = rs.getInt("id_pk");
                String nome = rs.getString("nome");
                String tipo = rs.getString("tipo1");
                String tipo2 = rs.getString("tipo2");
                
                if(tipo2.isBlank()){
                    System.out.print(" Pokémon:"+nome+"\n Tipo: "+tipo+"\n");
                }else{
                    System.out.print("Pokémon:"+nome+"\n Tipo: "+tipo+"/"+tipo2+"\n");
                }
            }else{
                System.out.print("ERRO! Pokémon ainda não cadastrado! Tente novamente mais tarde.");
            }
            rs.close();
        }catch (SQLException e){
            System.out.println("ERRO! Tente novamente.");
            throw new RuntimeException(e);
        }
        return "Pindamonhangaba";
    }
    
    public void update(String nome, String tipo1, String tipo2, int numero){
        StringBuilder comando = new StringBuilder("update iniciais set");
        ArrayList parametros = new ArrayList();
        
        if(!nome.isEmpty()){
            comando.append(" nome = ?, ");
            parametros.add(nome);
        }if(!tipo1.isEmpty()){
            comando.append(" tipo1 = ?, ");
            parametros.add(tipo1);
        }if(!tipo2.isEmpty()){
            comando.append(" tipo2 = ? ");
            parametros.add(tipo2);
        }
        
        comando.setLength(comando.length() - 2);
        comando.append(" where id_pk = ?");
        parametros.add(numero);
        
        try(
            Connection conn = abrir();
            PreparedStatement stmt = conn.prepareStatement(comando.toString());
        ){
            for(int i = 0; i < parametros.size(); i++){
                stmt.setObject(i+1, parametros.get(i));
            }

            int rs = stmt.executeUpdate();
            StringBuilder resultado = new StringBuilder();

            System.out.println(resultado.toString());
        }catch(SQLException e){
            System.out.println("ERRO! Tente novamente.");
            throw new RuntimeException(e);
        }
    }
    
    public void delete(int numero){
        String comando = "delete from iniciais where id_pk = ?";
        
        try(
            Connection conn = abrir();
            PreparedStatement stmt = conn.prepareStatement(comando);
        ){
            stmt.setInt(1, numero);
            stmt.execute();
            
            System.out.println("Registro deletado com sucesso.");
        }catch(SQLException e){
            System.out.println("ERRO! Tente novamente.");
            throw new RuntimeException(e);            
        }
    }
}
