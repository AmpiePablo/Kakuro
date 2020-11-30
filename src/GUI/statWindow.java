package GUI;
import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.border.LineBorder;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class statWindow extends JFrame implements ActionListener{
    private JLabel title;
    private mainWindow main;
    private JButton back;

    public statWindow(){
        componentsFrame();
        components();
    }

    public void componentsFrame(){
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setBounds(250,10,950,650);
        this.getContentPane().setBackground(Color.WHITE);
        setLayout(null);
        setResizable(false);
        setTitle("statistics");
        setVisible(true);
    }


    public void components(){
        back = new JButton();
        back.setText("volver");
        back.setBounds(10,10,50,20);
        back.addActionListener(this);
        add(back);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getSource().equals(back)){
            mainWindow win = new mainWindow();
            win.setVisible(true);
            dispose();
        }
    }
}
