package dto;

//table : ex1.board
public class BoardDto {
	private int boardNo;
	private String boardDistrict;
	private String boardTitle;
	private String boardContent;
	private String boardWriter;
	private String createdate;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardDistrict() {
		return boardDistrict;
	}
	public void setBoardDistrict(String boardDistrict) {
		this.boardDistrict = boardDistrict;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "BoardDto [boardNo=" + boardNo + ", boardDistrict=" + boardDistrict + ", boardTitle=" + boardTitle
				+ ", boardContent=" + boardContent + ", boardWriter=" + boardWriter + ", createdate=" + createdate
				+ "]";
	}	
}
