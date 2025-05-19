---
model: openrouter:google/gemini-2.0-flash-001
---

- name: translate
  prompt: |-
	Your task is to translate the provided text into the target language. Correct any spelling, grammatical or style mistakes.
	The input and target language are given at the start. If they are not given, try to guess the input language and translate to English.

	### INPUT
	english>russian. This is a formal announcement regarding the upcoming policy changes.
	### OUTPUT
	Это официальное объявление о предстоящих изменениях в политике.