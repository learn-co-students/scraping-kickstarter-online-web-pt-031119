require 'nokogiri'
require 'pry'

def title(project)
  project.css("h2.bbcard_name strong a").text
end

def image_link(project)
  project.css("div.project-thumbnail a img").attribute("src").value
end

def description(project)
  project.css("p.bbcard_blurb").text.strip
end

def location(project)
  project.css("ul.project-meta span.location-name").text
end

def percent_funded(project)
  project.css("ul.project-stats li.first.funded strong").text.sub("%", "").to_i
end

def create_project_hash

  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = kickstarter.css("li.project.grid_4")

  project_hash = {}
  projects.each do |project|
    project_hash[title(project).to_sym] = {
      image_link: image_link(project),
      description: description(project),
      location: location(project),
      percent_funded: percent_funded(project)
    }
  end

  project_hash

end


create_project_hash
