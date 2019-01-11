# encoding: utf-8
#
# Основной класс игры Game. Хранит состояние игры и предоставляет функции для
# развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.).
#
class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters, :status

  def initialize(slovo)
    @letters = get_letters(slovo)

    # Переменная @errors будет хранить текущее количество ошибок, всего можно
    # сделать не более 7 ошибок. Начальное значение — 0.
    @errors = 0

    @good_letters = []
    @bad_letters = []

    @status = 0
    #  0 – игра активна
    # -1 – игра закончена поражением
    #  1 – игра закончена победой
  end

  # Метод, который возвращает массив букв загаданного слова
  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Для игры введите загаданное слово в качестве аргумента при " \
        "запуске программы"
    end

    return Unicode::downcase(slovo.encode('UTF-8')).split("")
  end

  def next_step(bukva)
    # Предварительная проверка: если статус игры равен 1 или -1, значит игра
    # закончена и нет смысла дальше делать шаг. Выходим из метода возвращая
    # пустое значение.
    if @status == -1 || @status == 1
      return
    end

    # Если введенная буква уже есть в списке "правильных" или "ошибочных" букв,
    # то ничего не изменилось, выходим из метода.
    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end

    if @letters.include?(bukva) ||
      (bukva == "е" && @letters.include?("ё")) ||
      (bukva == "ё" && @letters.include?("е")) ||
      (bukva == "и" && @letters.include?("й")) ||
      (bukva == "й" && @letters.include?("и"))

      good_letters << bukva

      if bukva == "е"
        good_letters << "ё"
      end

      if bukva == "ё"
        good_letters << "е"
      end

      if bukva == "и"
        good_letters << "й"
      end

      if bukva == "й"
        good_letters << "и"
      end

      # Дополнительная проверка — угадано ли на этой букве все слово целиком.
      # Если да — меняем значение переменной @status на 1 — победа.
      if (good_letters & letters).sort == letters.uniq.sort
        @status = 1
      end
    else
      @bad_letters << bukva

      if bukva == "ё"
        bad_letters << "е"
      end

      if bukva == "е"
        bad_letters << "ё"
      end

      if bukva == "й"
        bad_letters << "и"
      end

      if bukva == "и"
        bad_letters << "й"
      end

      @errors += 1

      # Если ошибок больше 7 — статус игры меняем на -1, проигрыш.
      if @errors >= 7
        @status = -1
      end
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == ""
      letter = Unicode::downcase(STDIN.gets.encode("UTF-8").chomp)
    end

    next_step(letter)
  end
end
