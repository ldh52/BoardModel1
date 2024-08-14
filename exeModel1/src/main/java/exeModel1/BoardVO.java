package exeModel1;

import java.sql.Timestamp; // Import the correct Timestamp class

public class BoardVO {
    private int boardId;
    private String title;
    private String content;
    private String writer;
    private Timestamp regDate;
    private Timestamp modDate;

    // Constructor
    public BoardVO() {
        // Default constructor (no arguments)
    }

    // Constructor with arguments (for convenience when creating new BoardVO objects)
    public BoardVO(int boardId, String title, String content, String writer, Timestamp regDate, Timestamp modDate) {
        this.boardId = boardId;
        this.title = title;
        this.content = content;
        this.writer = writer;
        this.regDate = regDate;
        this.modDate = modDate;
    }

    // Getter and Setter methods for each attribute
    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }

	public void setTitle(String string)
	{
		// TODO Auto-generated method stub
		
	}

	public void setContent(String string)
	{
		// TODO Auto-generated method stub
		
	}

	public void setWriter(String string)
	{
		// TODO Auto-generated method stub
		
	}

	public void setRegDate(Timestamp timestamp)
	{
		// TODO Auto-generated method stub
		
	}

	public void setModDate(Timestamp timestamp)
	{
		// TODO Auto-generated method stub
		
	}

    // ... (Add similar getter and setter methods for other attributes)
}
