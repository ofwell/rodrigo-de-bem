# Input will come from file fed.txt
fed_file = File.new("html/docs/fed.txt", "r")

# One output will go as a formatted document to docs.html
# The other output will be the rows of the table in fedindex.html
$web_page = File.new("html/docs.html", "w")
$table_page = File.new("html/fedindex.html", "w") 

# The about.html is created separately since it makes no use of any Ruby feature in this project


#=========================
# HTML base code
#=========================
# The following blocks adds the basic foundation of the page layout in both pages (docs.html and fedindex.html)

$web_page.puts "
<!DOCTYPE html>
<html lang=\"en\">
    
    <head>
      <meta charset = \"UTF-8\">
      <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
      <link rel=\"stylesheet\" href=\"css/bootstrap.min.css\">
      <link href='https://fonts.googleapis.com/css?family=Anonymous+Pro' rel='stylesheet' type='text/css'>
      <link rel=\"stylesheet\" href=\"css/docs-style.css\">
      <link rel=\"shortcut icon\" href=\"images/favicon.ico\">
      <title>Federalist Papers</title>
    </head>\n\n"

$web_page.puts "\t<body>
  <div class = 'sidebar'>
    <a href='docs.html' alt='Home'> <img class='sideIcon' src='images/home.svg' alt='Icon'> </a>
    <a href='fedindex.html' alt='Table'> <img class='sideIcon' src='images/table-icon.svg' alt='Icon'> </a>
    <a href='about.html' alt='About'> <img class='sideIcon' src='images/about.svg' alt='Icon'> </a>
  </div>
"

$table_page.puts "
<!DOCTYPE html>
<html lang=\"en\">
    
    <head>
      <meta charset = \"UTF-8\">
      <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
      <link rel=\"stylesheet\" href=\"css/bootstrap.min.css\">
      <link href='https://fonts.googleapis.com/css?family=Anonymous+Pro' rel='stylesheet' type='text/css'>
      <link rel=\"stylesheet\" href=\"css/table-style.css\">
      <link rel=\"shortcut icon\" href=\"images/favicon.ico\">
      <title>Federalist Index</title>
    </head>\n\n"

$table_page.puts "\t<body>
  <div class = 'sidebar'>
    <a href='docs.html' alt='Home'> <img class='sideIcon' src='images/home.svg' alt='Icon'> </a>
    <a href='fedindex.html' alt='Table'> <img class='sideIcon' src='images/table-icon.svg' alt='Icon'> </a>
    <a href='about.html' alt='About'> <img class='sideIcon' src='images/about.svg' alt='Icon'> </a>
  </div>
  <div class = 'document'>
    <h2> Federalist Index </h2>
    <table>
      <tr><th>No.</th><th>Author</th><th>Title</th><th>Pub</th></tr>
"
# End of basic foundation blocks


#=========================
# Fed class
#=========================
# The class Fed holds information about a Federalist document

class Fed
	
	def initialize
		@fed_text = []
		@fed_title = []
    @fed_date = []
    @fed_place = []
	end

  def fed_no(n_input)
    @fed_no = n_input
  end

	def fed_number(num)
		@fed_number = num
  end

  def fed_title(title)
    @fed_title << title
  end

  def fed_date(date)
    @fed_date << date
  end

  def fed_place(place)
    @fed_place << place
  end

  def fed_author(auth)
    @fed_author = auth
  end

  def fed_text(text)
    @fed_text << text
  end

    # Method to print data on one Fed object into the Documents page (docs.html)
  def print
    $web_page.puts "\t\t<div class=\"document\">"
    $web_page.puts "\t\t\t<a name='" + @fed_number[2] + "'></a>"
    $web_page.puts "\t\t\t<h2>" + @fed_number.join(' ') + "</h2>"
    $web_page.puts "\t\t\t<h3>\n\t\t\t\t" + @fed_title.join(' ') + "\n\t\t\t</h3>"
    $web_page.puts "\t\t\t<h4>\n\t\t\t\t" + @fed_date.join(' ') + "\n\t\t\t</h4>"
    $web_page.puts "\t\t\t<h4>\n\t\t\t\t" + @fed_place.join(' ') + "\n\t\t\t</h4>"
    $web_page.puts "\t\t\t<div class=\"author\">"
    $web_page.puts "\t\t\t\t<img class=\"icon\" src=\"images/author.svg\" alt=\"Icon\">"
    $web_page.puts "\t\t\t\t<h4>" + @fed_author.join(' ') + "</h4>"
    $web_page.puts "\t\t\t</div>"
    $web_page.puts "\t\t\t<p>\n\t\t\t\t" + @fed_text.join(' ') + "\n\t\t\t</p>"
    $web_page.puts "\t\t</div>\n"
  end  

    # Method to create a row in the table with the current Fed object (fedindex.html)
    # There's a link (the <a href=''>) in each Title to the correspondant document on docs.html
  def print_table
        $table_page.puts "<tr> <td>" + @fed_no.to_s + "</td> <td>"+ @fed_author.join(' ') + "</td><td> <a href=docs.html#" + @fed_number[2] + ">" + @fed_title.join(' ') + "</td> <td>" + @fed_place.join(' ') + "</td> </tr>"
  end

end

#=========================
# Main program
#=========================

# Creates an array to hold each of the Fed documents
feds = []

# This variable keeps track of where in the file the program is
read_state = 'text'

#This variable keeps track of the documents' number
fed_no = 0

# Loop to read each line on fed.txt file
while(doc_line = fed_file.gets)			
	doc_line.strip!					
	doc_words = doc_line.split

	case
    # When the program finds the pattern of the FEDERALIST document header, it creates a new Fed object.
    when (read_state == 'text' and doc_words.length < 4 and doc_words[0] == 'FEDERALIST') 
      fed_no += 1
      curFed = Fed.new
      feds << curFed
      curFed.fed_no(fed_no)
      curFed.fed_number(doc_words)  
      read_state = 'b4title' # b4title will expect for the line where the title appears.

    when (read_state == 'b4title' and not doc_words.empty?)
      curFed.fed_title(doc_words)
      read_state = 'inTitle' # inTitle will check if the title takes more and one line.
    
    when (read_state == 'inTitle' and not doc_words.empty? and doc_words[0]== 'Tuesday,') # Check for a date before the title.
      curFed.fed_date(doc_words)

    when (read_state == 'inTitle' and not doc_words.empty? and doc_words[0]== 'Thursday,') # Check for a date before the title.
      curFed.fed_date(doc_words)

    when (read_state == 'inTitle' and not doc_words.empty? and doc_words[0]== 'Friday,') # Check for a date before the title.
      curFed.fed_date(doc_words)

    when (read_state == 'inTitle' and not doc_words.empty? and doc_words[0]== 'For') # Checks where the publication was made.
      curFed.fed_place(doc_words)

    when (read_state == 'inTitle' and not doc_words.empty? and doc_words[0]== 'From') # Checks where the publication was made.
      curFed.fed_place(doc_words)

    when (read_state == 'inTitle' and not doc_words.empty?) # Continues to check if the current line is part of the title.
      curFed.fed_title(doc_words)

    when (read_state == 'inTitle' and doc_words.empty?)
      curFed.fed_title(doc_words)
      read_state = 'b4author' # b4author will wait for the line where the author appears.

    when (read_state == 'b4author' and not doc_words.empty?)
      curFed.fed_author(doc_words)
      read_state = 'text' # The author only takes up one line so we change straight to text, getting the actual fed document text.

    when (read_state == 'text' and not doc_words.empty?) # Keeps adding the lines to the text part until it finds the header pattern again.
      curFed.fed_text(doc_words)
  end
end

# Closes the file with the formatted Federalist papers.
fed_file.close

# loop to print each document in the created docs.html file.
feds.each{|f| f.print}

$web_page.puts "\t</body>"
$web_page.puts "</html>"

# loop to print each row in the created fedindex.html file.
feds.each{|f| f.print_table}
$web_page.puts "</table> </div> </body> </html>"

# Closes the created files.
$table_page.close
$web_page.close