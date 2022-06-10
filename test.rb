line_count = gets.to_i
bingo_card = []
line_count.times do |i|
    bingo_card << gets.chomp.split(" ")
end
bingo_card.flatten! # 配列を平坦化(繰り返し処理なしで要素を検証するため)

winning_words = readlines(chomp: true).slice(1..)
winning_words.each do |winning_word|
    change_index = bingo_card.index(winning_word)
    unless change_index.nil?
        bingo_card[change_index] = 0
    end
end

bingo_card = bingo_card.each_slice(line_count).to_a # 平坦化したビンゴカードを配列形式へ復元

judge_bingo = false
# 横ラインのビンゴ確認処理
bingo_card.each do |line_result|
    if line_result.count(0) == line_count
        judge_bingo = true
        break
    end
end

# 縦ラインのビンゴ確認処理(未ビンゴ時のみ実行)
unless judge_bingo
    bingo_card_column = bingo_card.transpose  # 縦ラインの配列を作成
    bingo_card_column.each do |column_result|
        if column_result.count(0) == line_count
            judge_bingo = true
            break
        end
    end
end

# 右下がりのビンゴ確認処理(未ビンゴ時のみ実行)
unless judge_bingo
    lower_right = []
    line_count.times do |i|
        lower_right << bingo_card[i][i] # 右下がりラインの結果を抽出
    end
    
    if lower_right.count(0) == line_count
        judge_bingo = true
    end
end

# 左下がりのビンゴ確認処理(未ビンゴ時のみ実行)
unless judge_bingo
    lower_left = []
    line_count.times do |i|
        line_index = line_count - 1 - i
        lower_left << bingo_card[line_index][i] # 左下がりラインの結果を抽出
    end
    
    if lower_left.count(0) == line_count
        judge_bingo = true
    end
end

if judge_bingo
    puts "yes"
else
    puts "no"
end