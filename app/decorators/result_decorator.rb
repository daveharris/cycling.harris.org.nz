class ResultDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def previous_time_difference(attribute)
    previous = find_previous_result

    if previous
      previous_attribute = previous.public_send(attribute)
      current_attribute = result.public_send(attribute)
      
      difference = previous_attribute - current_attribute
        
      if difference > 0
        icon('arrow-circle-o-up', "#{duration_in_words(difference)} faster than last time")
      else
        icon('arrow-circle-o-down', "#{duration_in_words(difference)} slower than last time")
      end
    else
      icon('ban', "First Result")
    end
  end

end
