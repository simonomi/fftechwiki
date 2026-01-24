# [FF Tech Wiki](https://simonomi.dev/fftechwiki)
A site for technical Fossil Fighters documentation

## Contributing
Because the site is hosted on [GitHub Pages](https://docs.github.com/en/pages), there's no built-in page editor.

### Simple
1. Go to the page you want to edit
1. At the bottom, click the "Edit this page" link
1. Sign in to GitHub (create an account if you don't already have one)
1. If it appears, click the "Fork this repository" button (this should only happen once)
1. Edit the file to your satisfaction
1. Commit your changes
	1. Press the "Commit changes..." button
	1. Write a message explaining what you changed
	1. Press "Propose changes"
1. Create a pull request
	1. Press "Create pull request"
	1. Fill out the description if your change should have one
	1. Press "Create pull request"

#### Resources
- [HTML](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements)
- [Liquid](https://shopify.github.io/liquid/) (those `{{ }}` and `{%- -%}` things)
- [Cobalt](https://cobalt-org.github.io/docs/)
- [MathML](https://developer.mozilla.org/en-US/docs/Web/MathML/Tutorials/For_beginners/Getting_started) (how to write math formulas in HTML)

If you're getting started, I recommend looking at the code for existing pages. If you don't know how to do something, find a page that does what you want and copy how it does it.

#### Creating a new page
If you add a page, you should start with the template below. Make sure to change both the title and permalink.

```liquid
---
title: New Page
permalink: /new-page-url/
---

<p>Hello, world!</p>
```

### Advanced
If you want to preview your changes before you submit them, you'll need to [clone the repository locally](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository), [install Cobalt](https://cobalt-org.github.io/getting-started/), and run the terminal command `cobalt serve --open`. This is not advised unless you're already familiar with git, as you'll need to commit, push, and make a pull request for your changes manually.
