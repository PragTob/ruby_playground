# frozen_string_literal: true

class Bottles
  def song
    verses(99, 0)
  end

  def verses(start, finish)
    (finish..start).map { |number| verse(number) }.reverse.join("\n")
  end

  def verse(number)
    <<~VERSE
    #{n_bottles(number).capitalize} of beer on the wall, #{n_bottles(number)} of beer.
    #{get_beer(number)}, #{n_bottles(number - 1)} of beer on the wall.
    VERSE
  end

  private
  def n_bottles(number)
    case number
    when -1 then "99 bottles"
    when 0 then "no more bottles"
    when 1 then "1 bottle"
    else "#{number} bottles"
    end
  end

  def get_beer(number)
    case number
    when 0 then "Go to the store and buy some more"
    else "Take #{n_down(number)} down and pass it around"
    end
  end

  def n_down(number)
    case number
    when 1 then "it"
    else "one"
    end
  end
end
