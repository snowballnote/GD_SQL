package dto;

public class MemoDto {
	private int memoNo;
	private String memoCategory;
	private String memoTitle;
	private String memoContent;
	private String createdate;
	public int getMemoNo() {
		return memoNo;
	}
	public void setMemoNo(int memoNo) {
		this.memoNo = memoNo;
	}
	public String getMemoCategory() {
		return memoCategory;
	}
	public void setMemoCategory(String memoCategory) {
		this.memoCategory = memoCategory;
	}
	public String getMemoTitle() {
		return memoTitle;
	}
	public void setMemoTitle(String memoTitle) {
		this.memoTitle = memoTitle;
	}
	public String getMemoContent() {
		return memoContent;
	}
	public void setMemoContent(String memoContent) {
		this.memoContent = memoContent;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "MemoDto [memoNo=" + memoNo + ", memoCategory=" + memoCategory + ", memoTitle=" + memoTitle
				+ ", memoContent=" + memoContent + ", createdate=" + createdate + "]";
	}
	
	
}
