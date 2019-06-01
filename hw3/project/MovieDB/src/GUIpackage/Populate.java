package GUIpackage;
import java.sql.*;
import java.io.*;
import java.util.Set;
import java.util.HashSet;

public class Populate {
	private String MOVIE_DAT_FILE_PATH;
	private String MOVIE_GENRE_DAT_FILE_PATH;
	private String MOVIE_COUNTRY_DAT_FILE_PATH;
	private String MOVIE_LOCATION_DAT_FILE_PATH;
	private String TAG_DAT_FILE_PATH;
	private String MOVIE_TAG_DAT_FILE_PATH;

	private Connection con;

	public void run(String[] args) throws IOException {
		try {
			MOVIE_DAT_FILE_PATH = "datafile/movies.dat";
			MOVIE_GENRE_DAT_FILE_PATH = "datafile/movie_genres.dat";
			MOVIE_COUNTRY_DAT_FILE_PATH = "datafile/movie_countries.dat";
			MOVIE_LOCATION_DAT_FILE_PATH = "datafile/movie_locations.dat";
			TAG_DAT_FILE_PATH = "datafile/tags.dat";
			MOVIE_TAG_DAT_FILE_PATH = "datafile/movie_tags.dat";
			
			con = DBconnect.getConnect();
			System.out.println("Connect Successfully");
			init();
			insertMovies();
                        insertGenres();
			insertMovieCountry();
			insertMovieLocation();
			insertTags();
			insertMovieTag();

		} catch (SQLException ex) {
			ex.printStackTrace();
		} catch (ClassNotFoundException ex) {
			ex.printStackTrace();
		} finally {
			DBconnect.closeConnect(con);
		}
	}

	private void init() throws SQLException, ClassNotFoundException {
		System.out.println("Start initialization");
		cleanTable();
		System.out.println("End initialization");
	}

	private void cleanTable() throws SQLException, ClassNotFoundException {
		System.out.println("Clean Movies table");
		Statement statement = con.createStatement();
		statement.executeUpdate("DELETE FROM Movies");
                
                System.out.println("Clean Genres table");
		statement.executeUpdate("DELETE FROM Genres");
                
                System.out.println("Clean MovieCountry table");
		statement.executeUpdate("DELETE FROM MovieCountry");

		System.out.println("Clean MovieLocation table");
		statement.executeUpdate("DELETE FROM MovieLocation");

		System.out.println("Clean Tags table");
		statement.executeUpdate("DELETE FROM Tags");

		System.out.println("Clean MovieTag table");
		statement.executeUpdate("DELETE FROM MovieTag");
		statement.close();
		
	}

	private void insertMovieTag() throws IOException, SQLException, ClassNotFoundException {
		System.out.println("Reading Movie Tag file and insert data into MovieTag table");
		File file = new File(MOVIE_TAG_DAT_FILE_PATH);
		try (
			FileReader fileReader = new FileReader(file);
			BufferedReader reader = new BufferedReader(fileReader);
			) {
			String line = null;
			String sql = "INSERT INTO MovieTag (movieID, tagID, tagWeight) VALUES (?, ?, ?)";
			try (PreparedStatement preparedStatement = con.prepareStatement(sql)) {
				String MovieID = null, tagID = null;
				int tagWeight = 0;
				line = reader.readLine();
				while ((line = reader.readLine()) != null) {
					String[] ss = line.trim().split("\t");
					MovieID = ss[0];
					tagID = ss[1];
					tagWeight = Integer.parseInt(ss[2]);

					preparedStatement.setString(1, MovieID);
					preparedStatement.setString(2, tagID);
					preparedStatement.setInt(3, tagWeight);
					preparedStatement.executeUpdate();
				}
			}
		}
	}

	private void insertTags() throws IOException, SQLException, ClassNotFoundException {
		System.out.println("Reading Tags file and insert data into Tags table");
		File file = new File(TAG_DAT_FILE_PATH);
		try (
			FileReader fileReader = new FileReader(file);
			BufferedReader reader = new BufferedReader(fileReader);
			) {
			String line = null;
			String sql = "INSERT INTO Tags (tagID, tagText) VALUES (?, ?)";
			try (PreparedStatement preparedStatement = con.prepareStatement(sql)) {
				String tagID = null, tagText = null;
				line = reader.readLine();
				while ((line = reader.readLine()) != null) {
					String[] ss = line.trim().split("\t");
					tagID = ss[0];
					tagText = ss[1];

					preparedStatement.setString(1, tagID);
					preparedStatement.setString(2, tagText);
					preparedStatement.executeUpdate();
				}
			}
		}
	}

	private void insertMovieLocation() throws IOException, SQLException, ClassNotFoundException {
		System.out.println("Reading Movie Location file and insert data into MovieLocation table");
		File file = new File(MOVIE_LOCATION_DAT_FILE_PATH);
		try (

			FileReader fileReader = new FileReader(file);
			BufferedReader reader = new BufferedReader(fileReader);
			) {
			String line = null;
			String sql = "INSERT INTO MovieLocation (movieID, country) VALUES (?, ?)";
			try (PreparedStatement preparedStatement = con.prepareStatement(sql)) {
				String movieID = null, country = null;
				line = reader.readLine();
                                Set<String> set = new HashSet<>();
				while ((line = reader.readLine()) != null) {
					String[] ss = line.trim().split("\t");
                                        if (ss.length < 2) {
                                            continue;
                                        }
					movieID = ss[0];
					country = ss[1];
                                        String key = movieID + country;
                                        if (set.contains(key)) {
                                            continue;
                                        }
                                        set.add(key);
					preparedStatement.setString(1, movieID);
					preparedStatement.setString(2, country);
					preparedStatement.executeUpdate();
				}
			}
		}
	}
			
	private void insertMovieCountry() throws IOException, SQLException, ClassNotFoundException {
		System.out.println("Reading Movie Country file and insert data into MovieCountry table");
		File file = new File(MOVIE_COUNTRY_DAT_FILE_PATH);
		try (
			FileReader fileReader = new FileReader(file);
			BufferedReader reader = new BufferedReader(fileReader);
			) {
			String line = null;
			String sql = "INSERT INTO MovieCountry (movieID, country) VALUES (?, ?)";
			try (PreparedStatement preparedStatement = con.prepareStatement(sql)) {
				String movieID = null, country = null;
				line = reader.readLine();
				while ((line = reader.readLine()) != null) {
					String[] ss = line.trim().split("\t");
					movieID = ss[0];
					country = ss.length < 2 ? null : ss[1];
					
					preparedStatement.setString(1, movieID);
                                        if (country != null) {
                                            	preparedStatement.setString(2, country);
                                        } else {
						preparedStatement.setNull(2, java.sql.Types.VARCHAR);
					}
					
					preparedStatement.executeUpdate();
				}
			}
		}
	}

	private void insertGenres() throws IOException, SQLException, ClassNotFoundException {
		System.out.println("Reading Movie Genre file and insert data into Genres table");
		File file = new File(MOVIE_GENRE_DAT_FILE_PATH);
		try (
                        FileReader fileReader = new FileReader(file);
                        BufferedReader reader = new BufferedReader(fileReader);
			) {
			String line = null;
			String sql = "INSERT INTO Genres (movieID, genres) VALUES (?, ?)";
			try (PreparedStatement preparedStatement = con.prepareStatement(sql)) {
				String movieID = null, genres = null;
                                line = reader.readLine();
				while ((line = reader.readLine()) != null) {
					String[] ss = line.trim().split("\t");
					movieID = ss[0];
					genres = ss[1];
					
					preparedStatement.setString(1, movieID);
					preparedStatement.setString(2, genres);
					preparedStatement.executeUpdate();
				}
			}
		} 
	}

	private void insertMovies() throws IOException, SQLException, ClassNotFoundException {
		System.out.println("Reading Movies file and insert data into Movies table");
		File file = new File(MOVIE_DAT_FILE_PATH);
		try (
			FileReader fileReader = new FileReader(file);
			BufferedReader reader = new BufferedReader(fileReader);
			) {
			String line = null;
			String sql = "INSERT INTO Movies (movieID, title, year, rtAllCriticsRating, rtTopCriticsRating, rtAudienceRating, rtAllCriticsNumReviews, rtTopCriticsNumReviews, rtAudienceNumRatings) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			try (PreparedStatement preparedStatement = con.prepareStatement(sql)) {
				String movieID = null, title = null;
				Integer year = 0, rtAllCriticsNumReviews = 0, rtTopCriticsNumReviews = 0, rtAudienceNumRatings = 0;
				Float rtAllCriticsRating = (float)0.0, rtTopCriticsRating = (float)0.0, rtAudienceRating = (float)0.0;
				line = reader.readLine();
				while ((line = reader.readLine()) != null) {
					String[] ss = line.trim().split("\t");
					movieID = ss[0];
					title = ss[1];
					year = Integer.parseInt(ss[5]);
					rtAllCriticsRating = ss[7].equals("\\N") ? null : Float.parseFloat(ss[7]);
					rtAllCriticsNumReviews = ss[8].equals("\\N") ? null : Integer.parseInt(ss[8]);
                                        rtTopCriticsRating = ss[12].equals("\\N") ? null : Float.parseFloat(ss[12]);
                                        rtTopCriticsNumReviews = ss[13].equals("\\N") ? null : Integer.parseInt(ss[13]);
                                        rtAudienceRating = ss[17].equals("\\N") ? null : Float.parseFloat(ss[17]);
                                        rtAudienceNumRatings = ss[18].equals("\\N") ? null : Integer.parseInt(ss[18]);
					preparedStatement.setString(1, movieID);
					preparedStatement.setString(2, title);
					preparedStatement.setInt(3, year);
					if (rtAllCriticsRating != null) {
                                            	preparedStatement.setFloat(4, rtAllCriticsRating);
                                        } else {
						preparedStatement.setNull(4, java.sql.Types.FLOAT);
					}
                                        
                                        if (rtTopCriticsRating != null) {
                                            	preparedStatement.setFloat(5, rtTopCriticsRating);
                                        } else {
						preparedStatement.setNull(5, java.sql.Types.FLOAT);
					}
                                        
                                        if (rtAudienceRating != null) {
                                            	preparedStatement.setFloat(6, rtAudienceRating);
                                        } else {
						preparedStatement.setNull(6, java.sql.Types.FLOAT);
					}
                                        
					if (rtAllCriticsNumReviews != null) {
                                            	preparedStatement.setInt(7, rtAllCriticsNumReviews);
                                        } else {
						preparedStatement.setNull(7, java.sql.Types.INTEGER);
					}
                                        
					if (rtTopCriticsNumReviews != null) {
                                            	preparedStatement.setInt(8, rtTopCriticsNumReviews);
                                        } else {
						preparedStatement.setNull(8, java.sql.Types.INTEGER);
					}
                                        
					if (rtAudienceNumRatings != null) {
                                            	preparedStatement.setInt(9, rtAudienceNumRatings);
                                        } else {
						preparedStatement.setNull(9, java.sql.Types.INTEGER);
					}
					preparedStatement.executeUpdate();
				}
			}
		}
	}

	public static void main(String[] args) throws IOException {
		Populate p = new Populate();	
		p.run(args);
	}
}
