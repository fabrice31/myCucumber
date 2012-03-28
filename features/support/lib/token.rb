# use to got random value
# useful to post a data with random content but stock the value to check it
class Token
  def initialize
    @value = rand(256*256)
  end

  def value
    @value
  end
end
