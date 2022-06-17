line_count = gets.to_i
bingo_card = Array.new(line_count){gets.split}.flatten

winning_words = readlines(chomp: true).slice(1..)
winning_words.each do |winning_word|
    change_index = bingo_card.index(winning_word)
    bingo_card[change_index] = 0 unless change_index.nil?
end

bingo_card = bingo_card.each_slice(line_count).to_a # ビンゴカードを配列形式へ

#　縦
judge_bingo = bingo_card.transpose.any?{|v| v.count(0) == line_count}

# 横
judge_bingo = bingo_card.any?{|v| v.count(0) == line_count} unless judge_bingo

# 斜め
judge_bingo = Array.new(line_count){|i| bingo_card[i][i] }.all?{|v| v == 0} unless judge_bingo
judge_bingo = Array.new(line_count){|i| bingo_card[i][-i - 1] }.all?{|v| v == 0} unless judge_bingo


if judge_bingo
    puts "yes"
else
    puts "no"
end