package GUI;
import java.util.ArrayList;


public class Game {
    private int emptyCells;
    private int totalCells;
    private int countVerified;
    private int errorVerified;
    private String ending;
    private  int countSuggestion;
    private ArrayList<ArrayList<Integer>> current;
    private ArrayList<ArrayList<Integer>> solution;

    public Game(ArrayList<ArrayList<Integer>> pSolution,ArrayList<ArrayList<Integer>> pCurrent){
        this.current = pCurrent;
        this.solution = pSolution;
    }

    public int getEmptyCells() { return emptyCells; }
    public void setEmptyCells(int pEmptyCells){ this.emptyCells = pEmptyCells; }

    public int getTotalCells(){ return totalCells; }
    public void setTotalCells(int pTotalCells){ this.totalCells = pTotalCells; }

    public int getCountVerified(){ return countVerified; }
    public void setCountVerified(int pCountVerified){ this.countVerified = pCountVerified; }

    public int getErrorVerified(){ return errorVerified; }
    public void setErrorVerified(int pErrorVerified){ this.emptyCells = pErrorVerified; }

    public String getEnding(){ return ending; }
    public void setEnding(String pEnding){ this.ending = pEnding; }

    public int getCountSuggestion(){ return countSuggestion; }
    public void setCountSuggestion(int pSuggestion){ this.countVerified = pSuggestion; }

    public ArrayList<ArrayList<Integer>> getCurrent(){ return current; }
    public void setCurrent(ArrayList<ArrayList<Integer>> pCurrent){ this.current = pCurrent; }

    public ArrayList<ArrayList<Integer>> getSolution(){ return solution; }
    public void setSolution(ArrayList<ArrayList<Integer>> pSolution){ this.solution = pSolution; }

}
