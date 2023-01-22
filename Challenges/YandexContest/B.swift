/* 
# B. Канонический путь

<table><tbody><tr class="time-limit"><td class="property-title">Ограничение времени</td><td>1&nbsp;секунда</td></tr><tr class="memory-limit"><td class="property-title">Ограничение памяти</td><td>64Mb</td></tr><tr class="input-file"><td class="property-title">Ввод</td><td colspan="1">стандартный ввод или input.txt</td></tr><tr class="output-file"><td class="property-title">Вывод</td><td colspan="1">стандартный вывод или output.txt</td></tr></tbody></table>

По заданной строке, являющейся абсолютным адресом в Unix-системе, вам необходимо получить канонический адрес.

В Unix-системе "." соответсвутет текущей директории, ".." — родительской директории, при этом будем считать, что любое количество точек подряд, большее двух, соответствует директории с таким названием (состоящем из точек). "/" является разделителем вложенных директорий, причем несколько "/" подряд должны интерпретироваться как один "/".

Канонический путь должен обладать следующими свойствами:

1) всегда начинаться с одного "/"

2) любые две вложенные директории разделяются ровно одним знаком "/"

3) путь не заканчивается "/" (за исключением корневой директории, состоящего только из символа "/")

4) в каноническом пути есть только директории, т.е. нет ни одного вхождения "." или ".." как соответствия текущей или родительской директории

## Формат ввода

Вводится строка с абсолютным адресом, её длина не превосходит 100.

## Формат вывода

Выведите канонический путь.
*/

import Foundation

let pathString = readLine()!

let pathComponents = pathString.components(separatedBy: "/")
var canonicalComponents = [String]()

for component in pathComponents[1...] {
	if component == ".." {
		if canonicalComponents.count > 0 {
			canonicalComponents.removeLast(1)
		}	
	} else if !component.isEmpty && component != "." {
		canonicalComponents.append(component)
	}
}

print("/" + canonicalComponents.joined(separator: "/"))