package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.Product;

public class ProductRepository {

	private ArrayList<Product> listOfProducts = new ArrayList<>();
	//ProductRepository인스턴스를 하나만 공유하게끔 싱글톤 패턴을 이용함.
	private static ProductRepository instance = new ProductRepository();
	
	//DB접속에 필요한 코드
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private static String url = "jdbc:mysql://localhost:3306/webmarketdb";
	private static String user = "";
	private static String password = "";
	
	//ProductRepository인스턴스를 리턴하는 getter메서드
	public static ProductRepository getInstance() {
		return instance;
	}
	
	public ProductRepository() {
		
		//기초 상품 3개 추가하기 - 아래 데이터를 DB에서 가져오도록 변경
		/*
		 * Product phone = new Product("P1234", "Galaxy S20", 1200000);
		 * phone.setDescription("제품 상세 요약"); phone.setCategory("Smart Phone");
		 * phone.setManufacturer("삼성"); phone.setUnitsInStock(1000);
		 * phone.setCondition("New"); phone.setFilename("daniel-romero-s20.jpg");
		 * 
		 * Product notebook = new Product("P1235", "LG Gram", 2000000);
		 * notebook.setDescription("제품 상세 요약"); notebook.setCategory("노트북");
		 * notebook.setManufacturer("LG"); notebook.setUnitsInStock(1000);
		 * notebook.setCondition("refurbished");
		 * notebook.setFilename("andras-vas- Laptop.jpg");
		 * 
		 * Product tablet = new Product("P1236", "Galaxy Tab", 600000);
		 * tablet.setDescription("212.8*125.6*6.6mm, 제품 상세 요약");
		 * tablet.setCategory("태블릿"); tablet.setManufacturer("삼성");
		 * tablet.setUnitsInStock(100); tablet.setCondition("Old");
		 * tablet.setFilename("francois-hoang-tab.jpg");
		 * 
		 * Product catTower = new Product("P0001", "풀옵션 캣타워", 300000);
		 * catTower.setDescription("대형 3단 이상,<br> 가로 90cm 세로 60cm 높이 180cm");
		 * catTower.setCategory("가구"); catTower.setManufacturer("MMM");
		 * catTower.setUnitsInStock(10); catTower.setCondition("New");
		 * catTower.setFilename("petrebels-catTree.jpg");
		 * 
		 * 
		 * listOfProducts.add(phone); listOfProducts.add(notebook);
		 * listOfProducts.add(tablet); listOfProducts.add(catTower);
		 */
	}
	
	//모든 상품 정보를 넘겨주는 getter메서드
	public ArrayList<Product> getAllProducts(){
		String sql = "select * from product";
		
		try {
			conn = getConnection(); // 커넥션 얻기
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); // DB에 저장되어있는 상품들을 모두 가져 와서 ResultSet에 담고 있음.
			
			while(rs.next()) {
				Product product = new Product();
				//위의 빈 객체인 product에 각각 db에서 가져온 값을 저장 중
				product.setProductId(rs.getString("p_Id"));
				product.setPname(rs.getString("p_name"));
				product.setUnitPrice(rs.getInt("p_unitPrice"));
				product.setDescription(rs.getString("p_description"));
				product.setManufacturer(rs.getString("p_manufacturer"));
				product.setCategory(rs.getString("p_category"));
				product.setUnitsInStock(rs.getLong("p_unitsInStock"));
				product.setCondition(rs.getString("p_condition"));
				product.setFilename(rs.getString("p_filename"));
				
				//ArrayList컬렉션에다가 product객체를 추가하고 있다.
				listOfProducts.add(product);
				
			}
			
		} catch (Exception e) { e.printStackTrace(); }
		finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				System.out.println("DB연동 해제");
			} catch (Exception e2) { e2.printStackTrace(); }
		}
		//위에서 각 객체가 저장되어 ArrayList를 리턴하고 있음
		return listOfProducts;
	}
	
	
	// listOfProducts에 저장된 모든 상품 목록을 조회 해서 상품 아이디하고 일치하는 상품을 리턴 해주는 메서드
	public Product getProductById(String productId) {
		
		String sql = "select * from product where p_id = ?";
		Product productById = new Product();
		
		try {
			conn = getConnection(); // 커넥션 얻기
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productId);
			//인자값으로 넘어온 productId값에 해당하는 상품을 ResultSet객체에 하나만 저장함
			rs = pstmt.executeQuery();
			
			if(!rs.next()) {
				return null;
			}
			//인자값으로 넘어 온 productId값이 있다면...
			if(rs.next()) {
				productById.setProductId(rs.getString("p_Id"));
				productById.setPname(rs.getString("p_name"));
				productById.setUnitPrice(rs.getInt("p_unitPrice"));
				productById.setDescription(rs.getString("p_description"));
				productById.setManufacturer(rs.getString("p_manufacturer"));
				productById.setCategory(rs.getString("p_category"));
				productById.setUnitsInStock(rs.getLong("p_unitsInStock"));
				productById.setCondition(rs.getString("p_condition"));
				productById.setFilename(rs.getString("p_filename"));
			}
		} catch (Exception e) { e.getMessage();	}
		finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				System.out.println("DB연동 해제");
			} catch (Exception e2) { e2.printStackTrace(); }
		}
		
		/*
		 * for(int i=0; i<listOfProducts.size(); i++) { Product product =
		 * listOfProducts.get(i); if(product != null && product.getProductId() != null
		 * && product.getProductId().equals(productId)) { productById = product; break;
		 * } }
		 */
		return productById;
	}
	
	//상품을 추가하는 역할을 하는 메서드
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}
	
	//Connection 객체를 리턴하는 메서드(DB접속)
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password); //DB연결 객체를 얻고 있음
			System.out.println("DB연동 성공");
		} catch (Exception e) {
			System.out.println("DB연동 실패");
			System.out.print("DB연동 실패 이유 : ");
			e.printStackTrace();
		}
		return conn;
	}
	
}
