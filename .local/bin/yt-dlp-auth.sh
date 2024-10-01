#!/bin/sh

machine() {
	printf 'machine %s login %s password %s\n' "$1" "$2" "$3"
}

pw() {
	pass show "$1" | head -n1
}

machine nebula nikilirikili@gmail.com "$(pw nebula.tv/nikilirikili@gmail.com)"
machine watchnebula nikilirikili@gmail.com "$(pw nebula.tv/nikilirikili@gmail.com)"
