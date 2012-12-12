lvl1a = {
  required: [1, 1, 1, 1]
  optional: [1, 1, 1]
  cash: ["1-10", "1-6"]
  chests: ["1-100"]
  treasure: 100
}

lvl1b = {
  required: [2, 1, 2, 2, 2, 3]
  optional: [20, 1, 3, 3, 2, 5, 2, 2, 3]
  cash: ['3-18', '3-24', '5-29']
  chests: ['20-200']
  treasure: 170
}

xpFromGate = (difficulty) -> Math.floor(Math.pow(difficulty + 1, 1.5) * 10)

xpFromPath = (path, level) ->
  minimumXp = xpFromSeries(path.required, level)
  maximumXp = minimumXp + xpFromSeries(path.optional, level)
  "Minimum xp is #{minimumXp}.  Maximum is #{maximumXp}"

xpFromSeries = (series, level) ->
  xp = 0
  for gate in series
    xp += xpFromGate(gate) if gate <= level
  xp

moneyFromPath = (path, level) ->
  minimumMoney = moneyFromSeries(path.required, level)
  maximumGateMoney = minimumMoney + moneyFromSeries(path.optional, level)
  maximumRepeat = maximumGateMoney + moneyFromItems(path['cash'], level) + path['treasure']/3
  maximumFirst = maximumRepeat + moneyFromItems(path['chests'], level) + path['treasure']*2/3
  "min: #{minimumMoney}, all gates: #{maximumGateMoney}, repeats: #{maximumRepeat}, first: #{maximumFirst}"

moneyFromItems = (items, level) ->
  money = 0
  for item in items
    [difficulty, amount] = item.split('-')
    money += Math.floor(amount) if difficulty <= level #we need a toInt type function
  money

moneyFromGate = (difficulty) -> Math.floor(Math.pow(difficulty + 1, 1.7));

moneyFromSeries = (series, level) ->
  money = 0
  for gate in series
    money += moneyFromGate(gate) if gate <= level
  money

test = (path, level) ->
  console.log(moneyFromPath(path, level))
  console.log(xpFromPath(path, level))

test(lvl1b, 3)