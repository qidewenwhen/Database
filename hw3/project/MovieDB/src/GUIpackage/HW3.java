/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GUIpackage;
import java.sql.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashSet;
import java.util.Iterator;
/**
 *
 * @author oracle
 */
public class HW3 extends javax.swing.JFrame {

    /**
     * Creates new form MovieGUI
     */
    private Connection con;
    private HashSet<String> genresSet = new HashSet<>();
    private HashSet<String> countriesSet = new HashSet<>();
    private HashSet<String> locationSet = new HashSet<>();
    
    public HW3() {   
        try {    
            System.out.println("######### Initiating ########");
            initComponents();
            // Connect DB
            con = DBconnect.getConnect();
            System.out.println("Connect Successfully");
            init();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        } 
    }
    
    private void init() {
        try {
            // Query
            String sql = "SELECT DISTINCT genres\nFROM Genres\nORDER BY genres";
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            GenrePanel.setLayout(new GridLayout(0, 1));
            while (rs.next()) {
                JCheckBox genreCB = new JCheckBox();
                String genreName = rs.getString(1);
                genreCB.setText(genreName);
                GenrePanel.add(genreCB);
                genreCB.addActionListener(new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        if (genreCB.isSelected()) {
                            genresSet.add(genreName);
                        } else {
                            genresSet.remove(genreName);
                        }
                        SQLResultTextArea.setText(getQuerysql());
                    }
                });
            }
            rs.close();
            preparedStatement.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } 
    }
    
    private void initCountry() {
        try {
            countriesSet.clear();
            CountryPanel.removeAll();
            CountryPanel.revalidate();
            CountryPanel.repaint();
            // Generate query sql
            StringBuilder sql = new StringBuilder();
            String genre_sql = getGenresql();
            if (!genresSet.isEmpty()) {
                sql.append("SELECT DISTINCT mc.country\nFROM MovieCountry mc\nWHERE mc.movieID IN (\n")
                   .append(genre_sql).append(")\n")
                   .append("ORDER BY mc.country");
                //System.out.println(sql.toString());
                PreparedStatement preparedStatement = con.prepareStatement(sql.toString());
                ResultSet rs = preparedStatement.executeQuery();
                CountryPanel.setLayout(new GridLayout(0, 1));
                while (rs.next()) {
                    JCheckBox countryCB = new JCheckBox();
                    String countryName = rs.getString(1) == null ? "None" : rs.getString(1);                   
                    countryCB.setText(countryName);
                    CountryPanel.add(countryCB);
                    countryCB.addActionListener(new ActionListener() {
                        @Override
                        public void actionPerformed(ActionEvent e) {
                            if (countryCB.isSelected()) {
                                countriesSet.add(countryName);
                            } else {
                                countriesSet.remove(countryName);
                            }
                            SQLResultTextArea.setText(getQuerysql());
                        }
                    });
                }
                rs.close();
                preparedStatement.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    private void initLocation() {
        try {
            locationSet.clear();
            FilmLocPanel.removeAll();
            FilmLocPanel.revalidate();
            FilmLocPanel.repaint();
            // Generate Query SQL
            StringBuilder sql = new StringBuilder();
            String genre_sql = getGenresql();
            String country_sql = getCountrysql();
            if (!genresSet.isEmpty()) {
                sql.append("SELECT DISTINCT ml.country\nFROM MovieLocation ml\nWHERE ml.movieID IN\n(");
                if (!countriesSet.isEmpty()) {
                    sql.append(country_sql).append(") AND\nml.movieID IN\n(");
                }
                sql.append(genre_sql).append(")\n")
                   .append("ORDER BY ml.country");
                //System.out.println(sql.toString());
                PreparedStatement preparedStatement = con.prepareStatement(sql.toString());
                ResultSet rs = preparedStatement.executeQuery();
                FilmLocPanel.setLayout(new GridLayout(0, 1));
                while (rs.next()) {
                    JCheckBox locationCB = new JCheckBox();
                    String locationName = rs.getString(1);
                    locationCB.setText(locationName);
                    FilmLocPanel.add(locationCB); 
                    locationCB.addActionListener(new ActionListener() {
                        @Override
                        public void actionPerformed(ActionEvent e) {
                            if (locationCB.isSelected()) {
                                locationSet.add(locationName);
                            } else {
                                locationSet.remove(locationName);
                            }
                            SQLResultTextArea.setText(getQuerysql());
                        }
                    });
                }
                rs.close();
                preparedStatement.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    private void updateTag() {
        try {
            TagPanel.removeAll();
            TagPanel.revalidate();
            TagPanel.repaint();
            // Generate query
            StringBuilder sql = new StringBuilder();
            if (!genresSet.isEmpty()) {
                sql.append("SELECT DISTINCT t.tagText\nFROM Tags t, MovieTag m\nWHERE t.tagID = m.tagID(+) ");
                
                String tagValue = TagValueTextField.getText();
                if (tagValue.length() != 0 && Long.valueOf(tagValue) < Integer.MAX_VALUE) {
                    sql.append("AND\n m.tagWeight ")
                       .append(TagWeightComboBox.getSelectedItem().toString()).append(" ")
                       .append(Integer.parseInt(tagValue)).append(" ");
                }
                sql.append("AND\n m.movieID IN\n(").append(getQuerysqlHelper());
                sql.append("\nORDER BY t.tagText");
                
                //System.out.println(sql.toString());
                PreparedStatement preparedStatement = con.prepareStatement(sql.toString());
                ResultSet rs = preparedStatement.executeQuery();
                TagPanel.setLayout(new GridLayout(0, 1));
                int cnt = 0;
                while (rs.next()) {
                    cnt++;
                    JCheckBox tagCB = new JCheckBox();
                    tagCB.setText(rs.getString(1));
                    TagPanel.add(tagCB);  
                }
                TagCountTextField.setText(Integer.toString(cnt));
                rs.close();
                preparedStatement.close();
            }   
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    private void updateExecuteQuery() {
        try {
            QueryResultTextArea.setText("");
            if (!genresSet.isEmpty()) {
                String sql = getQuerysql();
                //System.out.println(sql.toString());
                PreparedStatement preparedStatement = con.prepareStatement(sql);
                ResultSet rs = preparedStatement.executeQuery();
                int cnt = 0, preID = 0;
                while (rs.next()) {
                    int curID = Integer.parseInt(rs.getString(1));
                    cnt = (curID == preID) ? cnt : cnt + 1;
                    preID = curID;
                    QueryResultTextArea.append(rs.getString(1));
                    for (int i = 2; i <= 8; i++) { 
                        QueryResultTextArea.append(", ");                       
                        QueryResultTextArea.append(rs.getString(i));
                    }
                    QueryResultTextArea.append("\n");
                }
                ResultCountTextField.setText(Integer.toString(cnt));
                rs.close();
                preparedStatement.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    private String getGenresql() {
        StringBuilder sb = new StringBuilder();
        Iterator<String> it = genresSet.iterator();
        if (!it.hasNext()) {
            return sb.toString();
        }
        sb.append("SELECT DISTINCT g2.movieID\nFROM Genres g2\nWHERE ")
          .append("g2.genres = '").append(it.next()).append("'");
        while (it.hasNext()) {
            if (SearchAttrComboBox.getSelectedIndex() == 0) {
                sb.append("\nINTERSECT\n");
            } else {
                sb.append("\nUNION\n");
            }
            sb.append("SELECT DISTINCT g2.movieID\nFROM Genres g2\nWHERE ")
              .append("g2.genres = '").append(it.next()).append("'");
        }
        return sb.toString();
    }
    
    private String getCountrysql() {
        StringBuilder sb = new StringBuilder();
        Iterator<String> it = countriesSet.iterator();
        if (!it.hasNext()) {
            return sb.toString();
        }       
        sb.append(getCountrysqlHelper(it.next()));
        while (it.hasNext()) {
            if (SearchAttrComboBox.getSelectedIndex() == 0) {
                sb.append("\nINTERSECT\n");
            } else {
                sb.append("\nUNION\n");
            }
            sb.append(getCountrysqlHelper(it.next()));
        }
        return sb.toString();
    }
    
    private String getCountrysqlHelper(String country) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT DISTINCT mc2.movieID\nFROM MovieCountry mc2\nWHERE ");
        if (country.equals("None")) {
            sb.append("mc2.country IS NULL");
        } else {
            sb.append("mc2.country = '").append(country).append("'");
        }
        return sb.toString();
    }
    
    private String getLocationsql() {
        StringBuilder sb = new StringBuilder();
        Iterator<String> it = locationSet.iterator();
        if (!it.hasNext()) {
            return sb.toString();
        }
        sb.append("SELECT DISTINCT ml2.movieID\nFROM MovieLocation ml2\nWHERE ")
          .append("ml2.country = '").append(it.next()).append("'");
        while (it.hasNext()) {
            if (SearchAttrComboBox.getSelectedIndex() == 0) {
                sb.append("\nINTERSECT\n");
            } else {
                sb.append("\nUNION\n");
            } 
            sb.append("SELECT DISTINCT ml2.movieID\nFROM MovieLocation ml2\nWHERE ")
              .append("ml2.country = '").append(it.next()).append("'");
        }
        return sb.toString();
    }
    
    private String getQuerysql() {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT m.movieID, m.title, g.genres, m.year, mc.country, ml.country, ROUND((m.rtAllCriticsRating + m.rtTopCriticsRating + m.rtAudienceRating) / 3.0, 2) AS average_rating, ROUND((m.rtAllCriticsNumReviews + m.rtTopCriticsNumReviews + m.rtAudienceNumRatings) / 3.0, 2) AS average_num_review\n") 
	  .append("FROM Movies m, Genres g, MovieCountry mc, MovieLocation ml\n")
	  .append("WHERE m.movieID = g.movieID(+) AND m.movieID = mc.movieID(+) AND m.movieID = ml.movieID(+)\n").append("AND m.movieID IN\n(");
        
        sb.append(getQuerysqlHelper());
        
        sb.append("\nORDER BY m.movieID");
        return sb.toString();
    }
    
    private String getQuerysqlHelper() {
        StringBuilder sb = new StringBuilder();
        
        sb.append(getGenresql()).append(")");
        
        if (!countriesSet.isEmpty()) {
            sb.append(" AND\n m.movieID IN\n(")
              .append(getCountrysql()).append(")");
        }

	if (!locationSet.isEmpty()) {
            sb.append(" AND\n m.movieID IN\n(")
              .append(getLocationsql()).append(")");
        }
        
        String rateValue = RateValueTextField.getText();
        if (rateValue.length() != 0 && Double.valueOf(rateValue) < Float.MAX_VALUE) {
            sb.append(" AND\n m.movieID IN\n(")
              .append("SELECT DISTINCT m2.movieID\nfrom Movies m2\nWHERE (m2.rtAllCriticsRating + m2.rtTopCriticsRating + m2.rtAudienceRating) / 3.0 ")
              .append(RateComboBox.getSelectedItem().toString()).append(" ")
              .append(Float.valueOf(rateValue)).append(")");
        }
       
        String reviewValue = ReviewValueTextField.getText();
        if (reviewValue.length() != 0 && Long.valueOf(reviewValue) < Integer.MAX_VALUE) {
            sb.append(" AND\n m.movieID IN\n(")
              .append("SELECT DISTINCT m2.movieID\nFROM Movies m2\nWHERE (m2.rtAllCriticsNumReviews + m2.rtTopCriticsNumReviews + m2.rtAudienceNumRatings) / 3.0 ")
              .append(ReviewNumComboBox.getSelectedItem().toString()).append(" ")
              .append(Integer.parseInt(reviewValue)).append(")");
        }
        
        String from = FromYearTextField.getText(), to = ToYearTextField.getText();
        if (!from.equals("YYYY") && !to.equals("YYYY") && from.length() != 0 && to.length() != 0) {
            sb.append(" AND\n m.movieID IN\n(")
              .append("SELECT DISTINCT m2.movieID\nFROM Movies m2\nWHERE ")
              .append("m2.year >= ").append(Integer.parseInt(from)).append(" AND\n m2.year <= ").append(Integer.parseInt(to))
              .append(")");
        }
        
        return sb.toString();
    }
    
    private void reset() {
        try {
            // reset checkbox set
            genresSet.clear();
            countriesSet.clear();
            locationSet.clear();
            
            // reset combobox
            RateComboBox.repaint();
            RateComboBox.setSelectedIndex(0);
            ReviewNumComboBox.repaint();
            ReviewNumComboBox.setSelectedIndex(0);
            TagWeightComboBox.repaint();
            TagWeightComboBox.setSelectedIndex(0);
            
            // reset panel
            GenrePanel.removeAll();
            GenrePanel.revalidate();
            GenrePanel.repaint();
            CountryPanel.removeAll();
            CountryPanel.revalidate();
            CountryPanel.repaint();
            FilmLocPanel.removeAll();
            FilmLocPanel.revalidate();
            FilmLocPanel.repaint();
            TagPanel.removeAll();
            TagPanel.revalidate();
            TagPanel.repaint();
            
            // reset textfield
            SQLResultTextArea.setText("");
            QueryResultTextArea.setText("");
            RateValueTextField.setText("");
            ReviewValueTextField.setText("");
            TagValueTextField.setText("");
            ResultCountTextField.setText("");
            TagCountTextField.setText("");
            FromYearTextField.setText("YYYY");
            ToYearTextField.setText("YYYY"); 
            
            init();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        GenereLabel = new javax.swing.JLabel();
        CountryLabel = new javax.swing.JLabel();
        FilmLocLabel = new javax.swing.JLabel();
        CritRateLabel = new javax.swing.JLabel();
        MovieTagLabel = new javax.swing.JLabel();
        RatePanel = new javax.swing.JPanel();
        RateComboBox = new javax.swing.JComboBox<>();
        ReviewNumComboBox = new javax.swing.JComboBox<>();
        RateValueTextField = new javax.swing.JTextField();
        ReviewValueTextField = new javax.swing.JTextField();
        RateLabel = new javax.swing.JLabel();
        RateValueLabel = new javax.swing.JLabel();
        ReviewNumLabel = new javax.swing.JLabel();
        ReviewValueLabel = new javax.swing.JLabel();
        YearPanel = new javax.swing.JPanel();
        ReviewValueLabel1 = new javax.swing.JLabel();
        FromYearTextField = new javax.swing.JTextField();
        ReviewValueLabel2 = new javax.swing.JLabel();
        ToYearTextField = new javax.swing.JTextField();
        MovieYearLabel = new javax.swing.JLabel();
        TagPanel2 = new javax.swing.JPanel();
        TagWeightLabel = new javax.swing.JLabel();
        TagWeightComboBox = new javax.swing.JComboBox<>();
        TagValueLabel = new javax.swing.JLabel();
        TagValueTextField = new javax.swing.JTextField();
        ListCountryButton = new javax.swing.JButton();
        ListFilmCountryButton = new javax.swing.JButton();
        SearchAttrComboBox = new javax.swing.JComboBox<>();
        SearchAttrLabel = new javax.swing.JLabel();
        ShowQueryPanel = new javax.swing.JPanel();
        ShowQueryLabel = new javax.swing.JLabel();
        ExeQueryButton = new javax.swing.JButton();
        jScrollPane7 = new javax.swing.JScrollPane();
        SQLResultTextArea = new javax.swing.JTextArea();
        ShowResultPanel = new javax.swing.JPanel();
        ShowResultLabel = new javax.swing.JLabel();
        ResultCountLabel = new javax.swing.JLabel();
        jScrollPane5 = new javax.swing.JScrollPane();
        QueryResultTextArea = new javax.swing.JTextArea();
        ResultCountTextField = new javax.swing.JTextField();
        ListTagButton = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jScrollPane1 = new javax.swing.JScrollPane();
        GenrePanel = new javax.swing.JPanel();
        jScrollPane2 = new javax.swing.JScrollPane();
        CountryPanel = new javax.swing.JPanel();
        jScrollPane3 = new javax.swing.JScrollPane();
        FilmLocPanel = new javax.swing.JPanel();
        ResetButton = new javax.swing.JButton();
        TagCountTextField = new javax.swing.JTextField();
        jScrollPane6 = new javax.swing.JScrollPane();
        TagPanel = new javax.swing.JPanel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Movie");
        setAlwaysOnTop(true);

        GenereLabel.setBackground(new java.awt.Color(99, 105, 112));
        GenereLabel.setForeground(new java.awt.Color(12, 22, 25));
        GenereLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        GenereLabel.setLabelFor(GenrePanel);
        GenereLabel.setText("Genres");
        GenereLabel.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(142, 133, 133)));
        GenereLabel.setOpaque(true);

        CountryLabel.setBackground(new java.awt.Color(99, 105, 112));
        CountryLabel.setForeground(new java.awt.Color(12, 22, 25));
        CountryLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        CountryLabel.setText("Country");
        CountryLabel.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(142, 133, 133)));
        CountryLabel.setOpaque(true);

        FilmLocLabel.setBackground(new java.awt.Color(99, 105, 112));
        FilmLocLabel.setForeground(new java.awt.Color(12, 22, 25));
        FilmLocLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        FilmLocLabel.setLabelFor(FilmLocPanel);
        FilmLocLabel.setText("Filming Location");
        FilmLocLabel.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(142, 133, 133)));
        FilmLocLabel.setOpaque(true);

        CritRateLabel.setBackground(new java.awt.Color(99, 105, 112));
        CritRateLabel.setForeground(new java.awt.Color(12, 22, 25));
        CritRateLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        CritRateLabel.setLabelFor(RatePanel);
        CritRateLabel.setText("Critics' Rating");
        CritRateLabel.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(142, 133, 133)));
        CritRateLabel.setOpaque(true);

        MovieTagLabel.setBackground(new java.awt.Color(99, 105, 112));
        MovieTagLabel.setForeground(new java.awt.Color(12, 22, 25));
        MovieTagLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        MovieTagLabel.setText("Movie Tag Values");
        MovieTagLabel.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(142, 133, 133)));
        MovieTagLabel.setOpaque(true);

        RatePanel.setBackground(new java.awt.Color(254, 254, 254));

        RateComboBox.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "=", "<", ">", "<=", ">=" }));
        RateComboBox.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                RateComboBoxActionPerformed(evt);
            }
        });

        ReviewNumComboBox.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "=", "<", ">", "<=", ">=" }));
        ReviewNumComboBox.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ReviewNumComboBoxActionPerformed(evt);
            }
        });

        RateValueTextField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                RateValueTextFieldActionPerformed(evt);
            }
        });

        ReviewValueTextField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ReviewValueTextFieldActionPerformed(evt);
            }
        });

        RateLabel.setLabelFor(RateComboBox);
        RateLabel.setText("Rate:");

        RateValueLabel.setLabelFor(RateValueTextField);
        RateValueLabel.setText("Value:");

        ReviewNumLabel.setLabelFor(ReviewNumComboBox);
        ReviewNumLabel.setText("Num.: ");

        ReviewValueLabel.setLabelFor(ReviewValueTextField);
        ReviewValueLabel.setText("Value:");

        javax.swing.GroupLayout RatePanelLayout = new javax.swing.GroupLayout(RatePanel);
        RatePanel.setLayout(RatePanelLayout);
        RatePanelLayout.setHorizontalGroup(
            RatePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, RatePanelLayout.createSequentialGroup()
                .addGap(13, 13, 13)
                .addComponent(RateLabel)
                .addGap(18, 18, 18)
                .addComponent(RateComboBox, javax.swing.GroupLayout.PREFERRED_SIZE, 127, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(15, Short.MAX_VALUE))
            .addGroup(RatePanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(RatePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, RatePanelLayout.createSequentialGroup()
                        .addComponent(RateValueLabel)
                        .addGap(10, 10, 10)
                        .addComponent(RateValueTextField))
                    .addGroup(RatePanelLayout.createSequentialGroup()
                        .addComponent(ReviewNumLabel)
                        .addGap(10, 10, 10)
                        .addComponent(ReviewNumComboBox, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                    .addGroup(RatePanelLayout.createSequentialGroup()
                        .addComponent(ReviewValueLabel)
                        .addGap(10, 10, 10)
                        .addComponent(ReviewValueTextField)))
                .addContainerGap())
        );
        RatePanelLayout.setVerticalGroup(
            RatePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(RatePanelLayout.createSequentialGroup()
                .addGap(23, 23, 23)
                .addGroup(RatePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(RateComboBox, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(RateLabel))
                .addGap(27, 27, 27)
                .addGroup(RatePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(RateValueTextField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(RateValueLabel))
                .addGap(30, 30, 30)
                .addGroup(RatePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(ReviewNumComboBox, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(ReviewNumLabel))
                .addGap(26, 26, 26)
                .addGroup(RatePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(ReviewValueTextField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(ReviewValueLabel))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        YearPanel.setBackground(new java.awt.Color(254, 254, 254));

        ReviewValueLabel1.setLabelFor(ReviewValueTextField);
        ReviewValueLabel1.setText("From:");

        FromYearTextField.setText("YYYY");
        FromYearTextField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                FromYearTextFieldActionPerformed(evt);
            }
        });

        ReviewValueLabel2.setLabelFor(ReviewValueTextField);
        ReviewValueLabel2.setText("To:");

        ToYearTextField.setText("YYYY");
        ToYearTextField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ToYearTextFieldActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout YearPanelLayout = new javax.swing.GroupLayout(YearPanel);
        YearPanel.setLayout(YearPanelLayout);
        YearPanelLayout.setHorizontalGroup(
            YearPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(YearPanelLayout.createSequentialGroup()
                .addGap(10, 10, 10)
                .addGroup(YearPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(ReviewValueLabel1)
                    .addComponent(ReviewValueLabel2))
                .addGap(10, 10, 10)
                .addGroup(YearPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(ToYearTextField)
                    .addComponent(FromYearTextField))
                .addContainerGap())
        );
        YearPanelLayout.setVerticalGroup(
            YearPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(YearPanelLayout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(YearPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(FromYearTextField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(ReviewValueLabel1))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(YearPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(ToYearTextField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(ReviewValueLabel2))
                .addGap(18, 18, 18))
        );

        MovieYearLabel.setBackground(new java.awt.Color(99, 105, 112));
        MovieYearLabel.setForeground(new java.awt.Color(12, 22, 25));
        MovieYearLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        MovieYearLabel.setLabelFor(YearPanel);
        MovieYearLabel.setText("Movie Year");
        MovieYearLabel.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(142, 133, 133)));
        MovieYearLabel.setOpaque(true);

        TagPanel2.setBackground(new java.awt.Color(254, 254, 254));

        TagWeightLabel.setLabelFor(TagWeightComboBox);
        TagWeightLabel.setText("Tag Weight:");

        TagWeightComboBox.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "=", "<", ">", "<=", ">=" }));

        TagValueLabel.setLabelFor(TagValueTextField);
        TagValueLabel.setText("Value:");

        javax.swing.GroupLayout TagPanel2Layout = new javax.swing.GroupLayout(TagPanel2);
        TagPanel2.setLayout(TagPanel2Layout);
        TagPanel2Layout.setHorizontalGroup(
            TagPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(TagPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(TagPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(TagPanel2Layout.createSequentialGroup()
                        .addComponent(TagWeightLabel)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(TagWeightComboBox, javax.swing.GroupLayout.PREFERRED_SIZE, 133, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(31, 31, 31))
                    .addGroup(TagPanel2Layout.createSequentialGroup()
                        .addComponent(TagValueLabel)
                        .addGap(10, 10, 10)
                        .addComponent(TagValueTextField)
                        .addContainerGap())))
        );
        TagPanel2Layout.setVerticalGroup(
            TagPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(TagPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(TagPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(TagWeightComboBox, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(TagWeightLabel))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(TagPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(TagValueTextField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(TagValueLabel))
                .addContainerGap(18, Short.MAX_VALUE))
        );

        ListCountryButton.setText("List Country");
        ListCountryButton.setOpaque(true);
        ListCountryButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ListCountryButtonActionPerformed(evt);
            }
        });

        ListFilmCountryButton.setText("List Film Country");
        ListFilmCountryButton.setOpaque(true);
        ListFilmCountryButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ListFilmCountryButtonActionPerformed(evt);
            }
        });

        SearchAttrComboBox.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "AND", "OR" }));
        SearchAttrComboBox.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                SearchAttrComboBoxActionPerformed(evt);
            }
        });

        SearchAttrLabel.setLabelFor(SearchAttrComboBox);
        SearchAttrLabel.setText("Search Between Attributes Value:");

        ShowQueryPanel.setBackground(new java.awt.Color(255, 255, 255));

        ShowQueryLabel.setLabelFor(ShowQueryPanel);
        ShowQueryLabel.setText("Show Query");

        ExeQueryButton.setText("Execute Query");
        ExeQueryButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ExeQueryButtonActionPerformed(evt);
            }
        });

        SQLResultTextArea.setColumns(20);
        SQLResultTextArea.setRows(5);
        jScrollPane7.setViewportView(SQLResultTextArea);

        javax.swing.GroupLayout ShowQueryPanelLayout = new javax.swing.GroupLayout(ShowQueryPanel);
        ShowQueryPanel.setLayout(ShowQueryPanelLayout);
        ShowQueryPanelLayout.setHorizontalGroup(
            ShowQueryPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(ShowQueryPanelLayout.createSequentialGroup()
                .addGroup(ShowQueryPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(ShowQueryPanelLayout.createSequentialGroup()
                        .addGroup(ShowQueryPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(ShowQueryPanelLayout.createSequentialGroup()
                                .addGap(118, 118, 118)
                                .addComponent(ShowQueryLabel))
                            .addGroup(ShowQueryPanelLayout.createSequentialGroup()
                                .addGap(90, 90, 90)
                                .addComponent(ExeQueryButton, javax.swing.GroupLayout.PREFERRED_SIZE, 136, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(0, 95, Short.MAX_VALUE))
                    .addGroup(ShowQueryPanelLayout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jScrollPane7)))
                .addContainerGap())
        );
        ShowQueryPanelLayout.setVerticalGroup(
            ShowQueryPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(ShowQueryPanelLayout.createSequentialGroup()
                .addComponent(ShowQueryLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 21, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane7, javax.swing.GroupLayout.PREFERRED_SIZE, 137, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(ExeQueryButton, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        ShowResultPanel.setBackground(new java.awt.Color(255, 255, 255));

        ShowResultLabel.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        ShowResultLabel.setText("Result");

        ResultCountLabel.setText("Resutl Count:");

        QueryResultTextArea.setColumns(20);
        QueryResultTextArea.setRows(5);
        jScrollPane5.setViewportView(QueryResultTextArea);

        ResultCountTextField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ResultCountTextFieldActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout ShowResultPanelLayout = new javax.swing.GroupLayout(ShowResultPanel);
        ShowResultPanel.setLayout(ShowResultPanelLayout);
        ShowResultPanelLayout.setHorizontalGroup(
            ShowResultPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(ShowResultPanelLayout.createSequentialGroup()
                .addGroup(ShowResultPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(ShowResultPanelLayout.createSequentialGroup()
                        .addGap(106, 106, 106)
                        .addComponent(ShowResultLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 74, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(ShowResultPanelLayout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(ShowResultPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(ShowResultPanelLayout.createSequentialGroup()
                                .addGap(12, 12, 12)
                                .addComponent(ResultCountLabel)
                                .addGap(27, 27, 27)
                                .addComponent(ResultCountTextField)
                                .addGap(32, 32, 32))
                            .addComponent(jScrollPane5, javax.swing.GroupLayout.DEFAULT_SIZE, 279, Short.MAX_VALUE))))
                .addContainerGap())
        );
        ShowResultPanelLayout.setVerticalGroup(
            ShowResultPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(ShowResultPanelLayout.createSequentialGroup()
                .addComponent(ShowResultLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 25, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane5, javax.swing.GroupLayout.PREFERRED_SIZE, 140, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(ShowResultPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(ResultCountTextField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(ResultCountLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
        );

        ListTagButton.setText("List Tag");
        ListTagButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ListTagButtonActionPerformed(evt);
            }
        });

        jLabel1.setText("Tag Count:");

        GenrePanel.setBackground(new java.awt.Color(255, 255, 255));

        javax.swing.GroupLayout GenrePanelLayout = new javax.swing.GroupLayout(GenrePanel);
        GenrePanel.setLayout(GenrePanelLayout);
        GenrePanelLayout.setHorizontalGroup(
            GenrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 144, Short.MAX_VALUE)
        );
        GenrePanelLayout.setVerticalGroup(
            GenrePanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 307, Short.MAX_VALUE)
        );

        jScrollPane1.setViewportView(GenrePanel);

        CountryPanel.setBackground(new java.awt.Color(255, 255, 255));

        javax.swing.GroupLayout CountryPanelLayout = new javax.swing.GroupLayout(CountryPanel);
        CountryPanel.setLayout(CountryPanelLayout);
        CountryPanelLayout.setHorizontalGroup(
            CountryPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 142, Short.MAX_VALUE)
        );
        CountryPanelLayout.setVerticalGroup(
            CountryPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 307, Short.MAX_VALUE)
        );

        jScrollPane2.setViewportView(CountryPanel);

        FilmLocPanel.setBackground(new java.awt.Color(255, 255, 255));

        javax.swing.GroupLayout FilmLocPanelLayout = new javax.swing.GroupLayout(FilmLocPanel);
        FilmLocPanel.setLayout(FilmLocPanelLayout);
        FilmLocPanelLayout.setHorizontalGroup(
            FilmLocPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 142, Short.MAX_VALUE)
        );
        FilmLocPanelLayout.setVerticalGroup(
            FilmLocPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 307, Short.MAX_VALUE)
        );

        jScrollPane3.setViewportView(FilmLocPanel);

        ResetButton.setText("Reset");
        ResetButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ResetButtonActionPerformed(evt);
            }
        });

        TagCountTextField.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                TagCountTextFieldActionPerformed(evt);
            }
        });

        TagPanel.setBackground(new java.awt.Color(255, 255, 255));

        javax.swing.GroupLayout TagPanelLayout = new javax.swing.GroupLayout(TagPanel);
        TagPanel.setLayout(TagPanelLayout);
        TagPanelLayout.setHorizontalGroup(
            TagPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 268, Short.MAX_VALUE)
        );
        TagPanelLayout.setVerticalGroup(
            TagPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 307, Short.MAX_VALUE)
        );

        jScrollPane6.setViewportView(TagPanel);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addContainerGap()
                                .addComponent(SearchAttrLabel)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(SearchAttrComboBox, javax.swing.GroupLayout.PREFERRED_SIZE, 169, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(12, 12, 12))
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(layout.createSequentialGroup()
                                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                            .addComponent(GenereLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 144, javax.swing.GroupLayout.PREFERRED_SIZE)
                                            .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 146, javax.swing.GroupLayout.PREFERRED_SIZE))
                                        .addGap(0, 0, 0)
                                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                            .addComponent(CountryLabel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                            .addComponent(jScrollPane2)))
                                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                                        .addContainerGap()
                                        .addComponent(ListCountryButton, javax.swing.GroupLayout.PREFERRED_SIZE, 102, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addGap(18, 18, 18)))
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(FilmLocLabel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                                        .addComponent(ListFilmCountryButton)
                                        .addGap(16, 16, 16))
                                    .addComponent(jScrollPane3))))
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(CritRateLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 205, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(0, 0, 0)
                                .addComponent(MovieTagLabel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(RatePanel, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                        .addComponent(YearPanel, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .addComponent(MovieYearLabel, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 205, Short.MAX_VALUE)))
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(layout.createSequentialGroup()
                                        .addGap(2, 2, 2)
                                        .addComponent(TagPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                                    .addGroup(layout.createSequentialGroup()
                                        .addGap(0, 0, 0)
                                        .addComponent(jScrollPane6))))))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(ShowQueryPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(3, 3, 3)
                        .addComponent(ShowResultPanel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(26, 26, 26)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(ListTagButton, javax.swing.GroupLayout.PREFERRED_SIZE, 136, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel1)
                                .addGap(18, 18, 18)
                                .addComponent(TagCountTextField, javax.swing.GroupLayout.PREFERRED_SIZE, 106, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(ResetButton, javax.swing.GroupLayout.PREFERRED_SIZE, 132, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(GenereLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(CountryLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(FilmLocLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(CritRateLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(MovieTagLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(RatePanel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGap(0, 0, 0)
                        .addComponent(MovieYearLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jScrollPane1)
                    .addComponent(jScrollPane2)
                    .addComponent(jScrollPane3)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGap(0, 0, 0)
                        .addComponent(jScrollPane6)))
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(ListCountryButton, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(ListFilmCountryButton, javax.swing.GroupLayout.PREFERRED_SIZE, 35, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(SearchAttrComboBox, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(SearchAttrLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addComponent(YearPanel, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(TagPanel2, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(3, 3, 3)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(ShowQueryPanel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(ShowResultPanel, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(27, 27, 27)
                        .addComponent(ListTagButton, javax.swing.GroupLayout.PREFERRED_SIZE, 36, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 27, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(TagCountTextField, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(36, 36, 36)
                        .addComponent(ResetButton, javax.swing.GroupLayout.PREFERRED_SIZE, 36, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(34, 34, 34))))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void ListCountryButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ListCountryButtonActionPerformed
        // TODO add your handling code here:
        initCountry();
        
    }//GEN-LAST:event_ListCountryButtonActionPerformed

    private void ListFilmCountryButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ListFilmCountryButtonActionPerformed
        // TODO add your handling code here:
        initLocation();
        
    }//GEN-LAST:event_ListFilmCountryButtonActionPerformed

    private void SearchAttrComboBoxActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_SearchAttrComboBoxActionPerformed
        // TODO add your handling code here:
        reset();
        //SQLResultTextArea.setText(getQuerysql());
    }//GEN-LAST:event_SearchAttrComboBoxActionPerformed

    private void FromYearTextFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_FromYearTextFieldActionPerformed
        // TODO add your handling code here:
        SQLResultTextArea.setText(getQuerysql());
    }//GEN-LAST:event_FromYearTextFieldActionPerformed

    private void RateValueTextFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_RateValueTextFieldActionPerformed
        // TODO add your handling code here:
        SQLResultTextArea.setText(getQuerysql());
    }//GEN-LAST:event_RateValueTextFieldActionPerformed

    private void ExeQueryButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ExeQueryButtonActionPerformed
        // TODO add your handling code here:
        updateExecuteQuery();
    }//GEN-LAST:event_ExeQueryButtonActionPerformed

    private void ListTagButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ListTagButtonActionPerformed
        // TODO add your handling code here:
        updateTag();
    }//GEN-LAST:event_ListTagButtonActionPerformed

    private void ResetButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ResetButtonActionPerformed
        // TODO add your handling code here:
        reset();
        SearchAttrComboBox.repaint();
        SearchAttrComboBox.setSelectedIndex(0);
    }//GEN-LAST:event_ResetButtonActionPerformed

    private void RateComboBoxActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_RateComboBoxActionPerformed
        // TODO add your handling code here:
        SQLResultTextArea.setText(getQuerysql());
    }//GEN-LAST:event_RateComboBoxActionPerformed

    private void ReviewNumComboBoxActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ReviewNumComboBoxActionPerformed
        // TODO add your handling code here:
        SQLResultTextArea.setText(getQuerysql());
    }//GEN-LAST:event_ReviewNumComboBoxActionPerformed

    private void ReviewValueTextFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ReviewValueTextFieldActionPerformed
        // TODO add your handling code here:
        SQLResultTextArea.setText(getQuerysql());
    }//GEN-LAST:event_ReviewValueTextFieldActionPerformed

    private void ToYearTextFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ToYearTextFieldActionPerformed
        // TODO add your handling code here:
        SQLResultTextArea.setText(getQuerysql());
    }//GEN-LAST:event_ToYearTextFieldActionPerformed

    private void ResultCountTextFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_ResultCountTextFieldActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_ResultCountTextFieldActionPerformed

    private void TagCountTextFieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_TagCountTextFieldActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_TagCountTextFieldActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(HW3.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(HW3.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(HW3.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(HW3.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new HW3().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel CountryLabel;
    private javax.swing.JPanel CountryPanel;
    private javax.swing.JLabel CritRateLabel;
    private javax.swing.JButton ExeQueryButton;
    private javax.swing.JLabel FilmLocLabel;
    private javax.swing.JPanel FilmLocPanel;
    private javax.swing.JTextField FromYearTextField;
    private javax.swing.JLabel GenereLabel;
    private javax.swing.JPanel GenrePanel;
    private javax.swing.JButton ListCountryButton;
    private javax.swing.JButton ListFilmCountryButton;
    private javax.swing.JButton ListTagButton;
    private javax.swing.JLabel MovieTagLabel;
    private javax.swing.JLabel MovieYearLabel;
    private javax.swing.JTextArea QueryResultTextArea;
    private javax.swing.JComboBox<String> RateComboBox;
    private javax.swing.JLabel RateLabel;
    private javax.swing.JPanel RatePanel;
    private javax.swing.JLabel RateValueLabel;
    private javax.swing.JTextField RateValueTextField;
    private javax.swing.JButton ResetButton;
    private javax.swing.JLabel ResultCountLabel;
    private javax.swing.JTextField ResultCountTextField;
    private javax.swing.JComboBox<String> ReviewNumComboBox;
    private javax.swing.JLabel ReviewNumLabel;
    private javax.swing.JLabel ReviewValueLabel;
    private javax.swing.JLabel ReviewValueLabel1;
    private javax.swing.JLabel ReviewValueLabel2;
    private javax.swing.JTextField ReviewValueTextField;
    private javax.swing.JTextArea SQLResultTextArea;
    private javax.swing.JComboBox<String> SearchAttrComboBox;
    private javax.swing.JLabel SearchAttrLabel;
    private javax.swing.JLabel ShowQueryLabel;
    private javax.swing.JPanel ShowQueryPanel;
    private javax.swing.JLabel ShowResultLabel;
    private javax.swing.JPanel ShowResultPanel;
    private javax.swing.JTextField TagCountTextField;
    private javax.swing.JPanel TagPanel;
    private javax.swing.JPanel TagPanel2;
    private javax.swing.JLabel TagValueLabel;
    private javax.swing.JTextField TagValueTextField;
    private javax.swing.JComboBox<String> TagWeightComboBox;
    private javax.swing.JLabel TagWeightLabel;
    private javax.swing.JTextField ToYearTextField;
    private javax.swing.JPanel YearPanel;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JScrollPane jScrollPane5;
    private javax.swing.JScrollPane jScrollPane6;
    private javax.swing.JScrollPane jScrollPane7;
    // End of variables declaration//GEN-END:variables
}
