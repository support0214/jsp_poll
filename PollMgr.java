package poll;

import java.sql.*;
import java.util.ArrayList;

public class PollMgr {
	private DBConnectionMgr pool;
	
	public PollMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int maxNum = 0;
		
		try {
			con = pool.getConnection();
			String sql = "select max(num) from polllist";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				maxNum = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	@SuppressWarnings("resource")
	public boolean insertPoll(PollListBean plBean, PollItemBean piBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			String sql = "insert into polllist values(SEQ_POLL.NEXTVAL,?,?,?,SYSDATE,?,DEFAULT)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, plBean.getQuestion());
			pstmt.setString(2, plBean.getSdate());
			pstmt.setString(3, plBean.getEdate());
			pstmt.setInt(4, plBean.getType());
			int result = pstmt.executeUpdate();
			int result2 = 0;
			if(result == 1) {
				sql = "insert into pollitem values(SEQ_POLL.CURRVAL,?,?,DEFAULT)";
				pstmt = con.prepareStatement(sql);
				String[] item = piBean.getItem();
				for(int i=0; i<item.length; i++) {
					if(item[i]==null || item[i].equals(""))
						break;
					pstmt.setInt(1, i);
					pstmt.setString(2, item[i]);
					result2 = pstmt.executeUpdate();
				}
				if(result2 == 1)
					flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public ArrayList<PollListBean> getAllList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<PollListBean> alist = new ArrayList<PollListBean>();
		
		try {
			con = pool.getConnection();
			String sql = "select * from polllist order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PollListBean plBean = new PollListBean();
				plBean.setNum(rs.getInt("num"));
				plBean.setQuestion(rs.getString("question"));
				plBean.setSdate(rs.getString("sdate"));
				plBean.setEdate(rs.getString("edate"));
				alist.add(plBean);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return alist;
	}
	
	public PollListBean getList(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PollListBean plBean = new PollListBean();
		
		try {
			con = pool.getConnection();
			String sql = null;
			if(num==0)
				sql = "select * from polllist order by num desc";
			else
				sql = "select * from polllist where num=" + num;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				plBean.setQuestion(rs.getString("question"));
				plBean.setType(rs.getInt("type"));
				plBean.setActive(rs.getInt("active"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return plBean;
	}
	
	public ArrayList<String> getItem(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> alist = new ArrayList<String>();
		
		try {
			con = pool.getConnection();
			if(num==0)
				num = getMaxNum();
			String sql = "select item from pollitem where listnum=" + num;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				alist.add(rs.getString(1));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return alist;
	}
	
	public boolean updatePoll(int num, String[] itemnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			String sql = "update pollitem set count = count + 1 where listnum=? and itemnum=?";
			pstmt = con.prepareStatement(sql);
			if(num==0)
				num = getMaxNum();
			
			for(int i = 0; i<itemnum.length; i++) {
				if(itemnum[i] == null || itemnum[i].equals(""))
					break;
				pstmt.setInt(1, num);
				pstmt.setInt(2, Integer.parseInt(itemnum[i]));
				if(pstmt.executeUpdate() == 1) {
					flag = true;
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	} 
	
	public int sumCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			con = pool.getConnection();
			String sql = "select sum(count) from pollitem where listnum=?";
			pstmt = con.prepareStatement(sql);
			if(num ==0)
				pstmt.setInt(1, getMaxNum());
			else
				pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next())
				count = rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	public ArrayList<PollItemBean> getView(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<PollItemBean> alist = new ArrayList<PollItemBean>();
		
		try {
			con = pool.getConnection();
			String sql = "select item, count from pollitem where listnum=?";
			pstmt = con.prepareStatement(sql);
			if(num==0)
				pstmt.setInt(1, getMaxNum());
			else
				pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PollItemBean piBean = new PollItemBean();
				String[] item = new String[1];
				item[0] = rs.getString("item");
				piBean.setItem(item);
				piBean.setCount(rs.getInt("count"));
				alist.add(piBean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return alist;
	}
}
