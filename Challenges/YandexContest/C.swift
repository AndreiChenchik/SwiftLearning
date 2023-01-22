/*
# C. Купить и продать

<table><tbody><tr class="time-limit"><td class="property-title">Ограничение времени</td><td>1&nbsp;секунда</td></tr><tr class="memory-limit"><td class="property-title">Ограничение памяти</td><td>64Mb</td></tr><tr class="input-file"><td class="property-title">Ввод</td><td colspan="1">стандартный ввод или input.txt</td></tr><tr class="output-file"><td class="property-title">Вывод</td><td colspan="1">стандартный вывод или output.txt</td></tr></tbody></table>

У вас есть 1000$, которую вы планируете эффективно вложить. Вам даны цены за 1000 кубометров газа за n дней. Можно один раз купить газ на все деньги в день i и продать его в один из последующих дней j, i < j.

Определите номера дней для покупки и продажи газа для получения максимальной прибыли.

## Формат ввода

В первой строке вводится число дней n (1 ≤ n ≤ 100000).

Во второй строке вводится n чисел — цены за 1000 кубометров газа в каждый из дней. Цена — целое число от 1 до 5000. Дни нумеруются с единицы.

## Формат вывода

Выведите два числа i и j — номера дней для покупки и продажи газа. Если прибыль получить невозможно, выведите два нуля.
*/

import Foundation

let nString = readLine()
let pricesString = readLine()

guard 
	let nString = nString,
	let pricesString = pricesString
else {
	exit(1)	
}

let n = Int(nString)!
let prices = pricesString.components(separatedBy: " ").compactMap { Int($0) }

var buyIndex = 0
var buyIndexCandidate = 0

var sellIndex = 0

var bestDeal = 0 
var maxBenefitCandidate = 0

for i in 0..<(n-1) {
	for j in (i+1)..<n {
		let newDeal = prices[j] - prices[i]

		if newDeal > bestDeal {
			buyIndex = i
			sellIndex = j
			bestDeal = newDeal
		}
	}
}

if bestDeal == 0 {
	print("0 0")
} else {
	print("\(buyIndex+1) \(sellIndex+1)")
}

