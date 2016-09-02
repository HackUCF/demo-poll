require 'mechanize' # needs mechanize - sudo gem install mechanize

@agent = Mechanize.new

@target_poll = "http://localhost:3000/polls/3"
@target_result = "mARBLECAKEALSOTHEGAME"

@done_people = [] # keep track of who is already in the correct position

# a class to store the people
class Person  
  def initialize(name, id)  
    @name = name  
    @id = id  
  end

  def get_name
    @name
  end

  def get_id
    @id
  end
end  

# get the raw page 
def get_page
  @agent.get(@target_poll)
end

# simple method to vote with cURL
def vote(option_id)
  response = `curl -s 'http://localhost:3000/polls/3/vote' --data 'option=#{option_id}' > /dev/null`

  return response.include? 'Thanks for voting!'
end

# is the given person in the list of done people? if so, we want to skip upvoting them any more
def is_done(person)
  @done_people.each do |d|
    if d.get_name == person.get_name
      return true
    end
  end

  return false
end

# get the current order of people and their ID
def get_current
  page = get_page

  people = []

  temp = @done_count
  page.search('table tbody tr').each do |tr|
    people << Person.new(
      tr.search('td').first.text,
      tr.search('input').first['value']
    )
  end

  return people
end

# get the rank of a given person in the poll
def get_rank(target_person)
  people = get_current
  people.each_with_index do |p, i|
    if p.get_name == target_person.get_name
      return i
    end
  end
end

# for each letter in mARBLECAKEALSOTHEGAME
@target_result.split("").each_with_index do |letter, target_rank|
  status = get_current # retrieve the current poll listing
  
  target_person = nil # define a target person variable

  # find the first person on the board whose name matches the target letter
  status.each do |person|
    next if is_done(person)
    if person.get_name()[0] == letter
        target_person = person
        break
    end
  end

  puts "target: #{target_person.get_name}"

  # upvote the target person until they are in correct spot
  while get_rank(target_person) > target_rank
    puts "target is in slot: #{get_rank target_person}. should be in: #{target_rank}"
    puts "upvoting #{target_person.get_name()}"
    vote(target_person.get_id())
  end

  # vote extra times to prevent ambiguous ties from screwing things up
  (("mARBLECAKEALSOTHEGAME".length - @done_people.size)*2).times do |ok|
    vote(target_person.get_id())
  end

  @done_people << target_person
end