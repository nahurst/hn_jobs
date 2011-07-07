# run get_jobs.rb before running this
# this will parse those files for counts
# then print things out to a csv file

require 'rubygems'
require 'nokogiri'
require 'csv'

COLLECTION_SETS = {
  :languages => [
    "python", "ruby", "java", "c++", "c#", "c", "scala", "lisp", "erlang",
    "haskell", "clojure", "groovy", "php", "javascript", "js", "html", 
    "css", "css3", "html5", "coffeescript", "scheme", "flash", "flex", 
    "actionscript", "sql", "objective-c", "obj-c", "perl"
  ],
  :data => [
    "mongo", "mongodb", "redis", "riak", "hadoop", "mysql", "postgres", 
    "postgresql", "memcachedb", "memcache", "memcached", "simpledb", 
    "couchdb", "sql server", "datamapper", "activerecord", "sequel", 
    "sql alchemy", "orm"
  ],
  :mobile => ["android", "iphone", "ios", "blackberry"],
  :frameworks => [
    "rails", "django", "lift", "drupal", "node", "node.js",
    "jquery", "prototype", "dojo", "backbone", "cake", "cakephp", "merb", 
    "sinatra", "pylons", "turbogears", "zope", "compojure", "spring"
  ]
}
HN_DATA = {}

def collect_counts(hn_doc_name, hn_doc_text)
  COLLECTION_SETS.each_pair do |collection_set_name, set|
    HN_DATA[collection_set_name] = {} unless HN_DATA.has_key?(collection_set_name) # should inject instead of setting up beforehand
    HN_DATA[collection_set_name][hn_doc_name] = {} unless HN_DATA[collection_set_name].has_key?(hn_doc_name)
    set.each do |term|
      # have to extract with a non-alpha character on each side to match
      # terms like "c" and "java" vs "javascript"
      count = hn_doc_text.scan(/[^a-z]#{Regexp.escape(term)}[^a-z]/im).size
      HN_DATA[collection_set_name][hn_doc_name][term] = count
    end
  end
end

def csv_counts
  CSV.open("hn_data.csv", "wb") do |csv|
    HN_DATA.keys.sort.each do |collection_set_name|
      csv << [collection_set_name]
      column_headings = HN_DATA[collection_set_name].keys.sort.inject([""]){ |all, item| all << item }
      row_headings = COLLECTION_SETS[collection_set_name].sort

      csv << column_headings

      row_headings.each do |term|
        row = [term]
        HN_DATA[collection_set_name].keys.sort.each do |hn_doc_name|
          row << HN_DATA[collection_set_name][hn_doc_name][term]
        end
        csv << row
      end
      csv << []
    end
  end
end

files = Dir.glob("*.html")
files.each do |file_name|
  File.open(file_name) do |f|
    doc = Nokogiri::HTML(f)
    doc.css('script').each { |node| node.remove }
    doc.css('link').each { |node| node.remove }
    text = doc.xpath("//span[@class='comment']//text()").to_a.join("\n")
  
    collect_counts(File.basename(file_name, ".html"), text)
  end
end
csv_counts
