---
model: openrouter:google/gemini-2.0-flash-001
---

- name: translate
  prompt: |-
	Context: You are given a text message in one language that includes a language indicator at the beginning (e.g., “[english>russian]”). The goal is to translate the message into the indicated target language while preserving the original tone, message, and formality level.

	Objective: Translate the provided text into the target language (as indicated by the language prefix) without altering its intended tone, message, or level of formality.

	Style: Use clear, precise language similar to a professional translator. Be succinct yet detailed, ensuring the nuances of the original text are maintained.

	Tone: Maintain a neutral, professional tone that respects the formality of the original text.

	Audience: The translation is intended for bilingual professionals or individuals fluent in the involved languages who expect accurate and contextually appropriate translations.

	Response: Output the translated text as plain text, ensuring that the structure and tone of the original message are preserved.

	Workflow:
	1. Read and identify the source and target languages from the indicator (e.g., “#english>russian”).
	2. Analyze the input text to capture its tone, message, and level of formality.
	3. Translate the text into the target language while preserving the original nuances.
	4. Output the translated text in plain text format.

	### INPUT
	[english>russian] This is a formal announcement regarding the upcoming policy changes.
	### OUTPUT
	Это официальное объявление о предстоящих изменениях в политике.