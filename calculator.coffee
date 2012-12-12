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
  chests: ['20-3155']
  treasure: 170
}

lvl1c = {
  required: [6,5,6,5,6,6,5,6,4,6,6]
  optional: [6,5,6,15,7,6,6,8,11,10]
  cash: ["6-82", "11-214", "6-89", "10-207"]
  chests: ["15-2179"]
  treasure: 1296
}

lvl2a = {
  required: [4,4,4,4,4,4,4,4,4,4,4]
  optional: [4,4,4,4,4,6,7,5,8,5,5,5,12]
  cash: [""]
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

test(lvl1a, 10)





