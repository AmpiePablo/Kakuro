package GUI;
import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.border.LineBorder;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.util.ArrayList;


public class GameWindow extends JFrame implements ActionListener{
    //labels
    private JLabel title;
    private JLabel lblBack;
    private JLabel lblExit;
    private JLabel lblSave;
    private JLabel lblSolution;
    private JLabel lblSuggestion;
    private JLabel lblRestart;
    private JLabel lblVerify;
    //buttons
    private JButton back;
    private JButton btnExit;
    private JButton btnSave;
    private JButton btnSolution;
    private JButton btnSuggestion;
    private JButton btnRestart;
    private JButton btnVerify;
    //board
    private int[][] test;
    private ArrayList<ArrayList<JButton>> matrixButton;
    private int cX;
    private int cY;

    public GameWindow(){
        this.matrixButton = new ArrayList<ArrayList<JButton>>();
        this.cX = 20;
        this.cY = 90;
        this.test = new int[][]{{0, 0, 1, 1, 0, 0, 1, 1, 0},
                {0, 1, 2, 2, 1, 1, 2, 2, 1},
                {0, 1, 2, 2, 2, 1, 2, 2, 2},
                {1, 2, 2, 2, 2, 1, 2, 2, 2},
                {1, 2, 2, 1, 2, 2, 2, 1, 1},
                {0, 1, 1, 2, 2, 2, 1, 2, 2},
                {1, 2, 2, 2, 1, 2, 2, 2, 2},
                {1, 2, 2, 2, 1, 2, 2, 2, 0},
                {0, 1, 2, 2, 0, 1, 2, 2, 0},};
        componentsFrame();
        createBoard(test);
        components();
    }

    public void createBoard(int [][] pBoard){
        for(int i = 0;i<pBoard.length;i++){
            ArrayList<JButton> temp = new ArrayList<JButton>();
            for(int j = 0; j < pBoard[i].length;j++){
                JButton btnTemp = new JButton();
                btnTemp.setBounds(cX,cY,45,45);
                if(pBoard[i][j] == 0){
                    btnTemp.setText("0");
                    btnTemp.setEnabled(false);
                }else if(pBoard[i][j]==1){
                    btnTemp.setText("1");
                    btnTemp.setEnabled(false);
                }else if(pBoard[i][j]==2){
                    btnTemp.setText("2");
                    btnTemp.setEnabled(true);
                }
                btnTemp.addActionListener(this);
                add(btnTemp);
                temp.add(btnTemp);
                cX+=45;
            }
            cX = 20;
            cY += 43;
            matrixButton.add(temp);
        }
    }

    public void componentsFrame(){
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setBounds(250,10,950,650);
        this.getContentPane().setBackground(Color.WHITE);
        setLayout(null);
        setResizable(false);
        setTitle("Game Kakuro");
        setVisible(true);
    }

    public void components() {
        try {
            Image imgBack = ImageIO.read(this.getClass().getResourceAsStream("../Imagenes/back.png"));
            Image imgExit = ImageIO.read(this.getClass().getResourceAsStream("../Imagenes/exit.png"));
            Image imgSuggestion = ImageIO.read(this.getClass().getResourceAsStream("../Imagenes/suggestion.png"));
            Image imgSolution = ImageIO.read(this.getClass().getResourceAsStream("../Imagenes/puzzle.png"));
            Image imgSave = ImageIO.read(this.getClass().getResourceAsStream("../Imagenes/diskette.png"));
            Image imgRestart = ImageIO.read(this.getClass().getResourceAsStream("../Imagenes/restart.png"));
            Image imgVerify = ImageIO.read(this.getClass().getResourceAsStream("../Imagenes/check.png"));


            title = new JLabel("KAKURO");
            lblBack = new JLabel("Volver");
            lblExit = new JLabel("Salir");
            lblRestart = new JLabel("Reiniciar");
            lblSave = new JLabel("Guardar");
            lblSuggestion = new JLabel("Sugerencia");
            lblSolution = new JLabel("Ver Solución");
            lblVerify = new JLabel("Verificar");

            title.setFont(new Font("Times New Roman",Font.PLAIN,36));
            lblBack.setFont(new Font("Times New Roman",Font.PLAIN,10));;
            lblExit.setFont(new Font("Times New Roman",Font.PLAIN,10));
            lblRestart.setFont(new Font("Times New Roman",Font.PLAIN,14));
            lblSave.setFont(new Font("Times New Roman",Font.PLAIN,14));
            lblSuggestion.setFont(new Font("Times New Roman",Font.PLAIN,14));
            lblSolution.setFont(new Font("Times New Roman",Font.PLAIN,14));
            lblVerify.setFont(new Font("Times New Roman",Font.PLAIN,20));

            title.setBounds(600,25,190,90);
            lblBack.setBounds(5,30,90,20);
            lblExit.setBounds(45,30,90,20);
            lblRestart.setBounds(470,340,90,90);
            lblSuggestion.setBounds(460,425,90,90);
            lblSolution.setBounds(595,340,90,90);
            lblSave.setBounds(610,425,90,93);
            lblVerify.setBounds(750,430,170,70);

            title.setBackground(Color.WHITE);
            lblBack.setBackground(Color.WHITE);
            lblExit.setBackground(Color.WHITE);
            lblRestart.setBackground(Color.WHITE);
            lblSave.setBackground(Color.WHITE);
            lblSuggestion.setBackground(Color.WHITE);
            lblSolution.setBackground(Color.WHITE);
            lblVerify.setBackground(Color.WHITE);

            title.setForeground(new Color(48,231,175));
            lblBack.setForeground(new Color(48,231,175));
            lblExit.setForeground(new Color(245,61,86));
            lblRestart.setForeground(new Color(248,196,113));
            lblSave.setForeground(new Color(248,196,113));
            lblSuggestion.setForeground(new Color(248,196,113));
            lblSolution.setForeground(new Color(248,196,113));
            lblVerify.setForeground(new Color(248,196,113));

            add(title);
            add(lblBack);
            add(lblExit);
            add(lblRestart);
            add(lblSave);
            add(lblSolution);
            add(lblSuggestion);
            add(lblVerify);

            back = new JButton();
            back.setBounds(1, 1, 33, 33);
            back.setIcon(new ImageIcon(imgBack));
            back.setBorder(new LineBorder(Color.WHITE));
            back.setContentAreaFilled(false);
            back.setCursor(Cursor.getPredefinedCursor(12));
            back.addActionListener(this);
            add(back);

            btnExit = new JButton();
            btnExit.setBounds(40,1,33,33);
            btnExit.setIcon(new ImageIcon(imgExit));
            btnExit.setBorder(new LineBorder(Color.WHITE));
            btnExit.setContentAreaFilled(false);
            btnExit.setCursor(Cursor.getPredefinedCursor(12));
            btnExit.addActionListener(this);
            add(btnExit);

            btnRestart = new JButton();
            btnRestart.setBounds(460,310,65,65);
            btnRestart.setIcon(new ImageIcon(imgRestart));
            btnRestart.setBorder(new LineBorder(Color.WHITE));
            btnRestart.setContentAreaFilled(false);
            btnRestart.setCursor(Cursor.getPredefinedCursor(12));
            btnRestart.addActionListener(this);
            add(btnRestart);

            btnSuggestion = new JButton();
            btnSuggestion.setBounds(460,400,65,65);
            btnSuggestion.setIcon(new ImageIcon(imgSuggestion));
            btnSuggestion.setBorder(new LineBorder(Color.WHITE));
            btnSuggestion.setContentAreaFilled(false);
            btnSuggestion.setCursor(Cursor.getPredefinedCursor(12));
            btnSuggestion.addActionListener(this);
            add(btnSuggestion);

            btnSolution = new JButton();
            btnSolution.setBounds(600,310,65,65);
            btnSolution.setIcon(new ImageIcon(imgSolution));
            btnSolution.setBorder(new LineBorder(Color.WHITE));
            btnSolution.setContentAreaFilled(false);
            btnSolution.setCursor(Cursor.getPredefinedCursor(12));
            btnSolution.addActionListener(this);
            add(btnSolution);

            btnSave = new JButton();
            btnSave.setBounds(600,400,65,65);
            btnSave.setIcon(new ImageIcon(imgSave));
            btnSave.setBorder(new LineBorder(Color.WHITE));
            btnSave.setContentAreaFilled(false);
            btnSave.setCursor(Cursor.getPredefinedCursor(12));
            btnSave.addActionListener(this);
            add(btnSave);

            btnVerify = new JButton();
            btnVerify.setBounds(720,320,130,130);
            btnVerify.setIcon(new ImageIcon(imgVerify));
            btnVerify.setBorder(new LineBorder(Color.WHITE));
            btnVerify.setContentAreaFilled(false);
            btnVerify.setCursor(Cursor.getPredefinedCursor(12));
            btnVerify.addActionListener(this);
            add(btnVerify);
        }catch(Exception ex){
            System.out.println(ex);
        }
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getSource().equals(back)){
            mainWindow win = new mainWindow();
            dispose();
        }
        if(e.getSource().equals(btnExit)){
            dispose();
            System.exit(0);
        }

        for(int i = 0; i<matrixButton.size();i++){
            for(int j = 0; j<matrixButton.get(i).size();j++){
                if(e.getSource().equals(matrixButton.get(i).get(j))){
                    System.out.println(matrixButton.get(i).get(j).getText());
                }
            }
        }
    }
}
