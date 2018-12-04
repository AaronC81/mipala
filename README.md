# Mipala
Mipala is the **mi**nimalistic **pa**per **la**nguage. It's designed to be more
powerful than Markdown, so that's it's sufficient for papers and reports, while 
much less complicated than LaTeX.

## Syntax
Mipala uses a tidy, indentation-based syntax inspired in part by Python. Here's
an excerpt of what syntax will look like.

```
This is a line of text.
This line has \bold(bold text).
This line also has **bold text** in a slightly easier way.
Let's introduce a new __environment__ of quoted text:
\blockquote(Somebody):
  Insert a quotation here; it will appear centred and italic.
Now the quote is over. 
```

## Design goals
There are four key goals to the design of Mipala.

  - **Keep everything simple.** Use sensible defaults so the user has minimal
  configration, but make overriding these defaults obvious and easy.

  - **Be consistent.** Don't introduce unnecessary new features which deviate
  from the norm.

  - **If the previous two clash, consistency is priority.** Don't add unusual
  usage cases or "magic" to the language to make things easier to use. Keep to
  the existing constraints of the language.

  - **Design around DRY.** The language's reference system should allow the user
  to never have to repeat anything.
