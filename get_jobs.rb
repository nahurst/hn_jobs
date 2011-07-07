[
  ["2011-07", "http://news.ycombinator.com/item?id=2719028"],
  ["2011-06", "http://news.ycombinator.com/item?id=2607052"],
  ["2011-05", "http://news.ycombinator.com/item?id=2503204"],
  ["2011-04", "http://news.ycombinator.com/item?id=2396027"],
  ["2011-03", "http://news.ycombinator.com/item?id=2270790"],
  ["2011-02", "http://news.ycombinator.com/item?id=2161360"],
  ["2011-01", "http://news.ycombinator.com/item?id=2057704"],
  ["2010-12", "http://news.ycombinator.com/item?id=1957538"],
  ["2010-11", "http://news.ycombinator.com/item?id=1855569"],
  ["2010-10", "http://news.ycombinator.com/item?id=1748045"],
  ["2010-09", "http://news.ycombinator.com/item?id=1659409"],
  ["2010-07", "http://news.ycombinator.com/item?id=1490922"],
  ["2010-06", "http://news.ycombinator.com/item?id=1438505"],
  ["2010-05", "http://news.ycombinator.com/item?id=1308582"],
  ["2010-04", "http://news.ycombinator.com/item?id=1215633"],
  ["2009-11", "http://news.ycombinator.com/item?id=952915"],
  ["2009-08", "http://news.ycombinator.com/item?id=759452"],
  ["2008-11", "http://news.ycombinator.com/item?id=375410"]
].each do |month_url|
  `wget #{month_url[1]} -O #{month_url[0]}.html`
end
