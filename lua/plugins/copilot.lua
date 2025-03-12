local commit_prompt = [[
# Commit Message Writing Guide

When writing commit messages, please follow these guidelines to ensure clarity and consistency:

## Format

Write commit messages in the following format:
```
<type>: <short summary>

- [optional detailed description 1]
- [optional detailed description 2]
...
```

## Type Prefixes

Begin each commit message with one of these type prefixes:

- `feat:` - New features or functionality added to the codebase
- `fix:` - Bug fixes
- `refactor:` - Code changes that neither fix bugs nor add features (improved code structure)
- `style:` - Changes that don't affect code functionality (whitespace, formatting, indentation)
- `chore:` - Maintenance tasks, dependency updates, configuration changes (e.g., changes to Cargo.toml)
- `test:` - Adding or modifying tests (Note: All test-related changes use this prefix, even if they involve adding new test features or refactoring tests)
- `docs:` - Documentation changes
- `perf:` - Performance improvements

## Guidelines

1. **Be concise**: Keep the summary line under 50 characters
2. **Be specific**: Clearly state what the commit does, not what it intends to do
3. **Use imperative mood**: Write "add feature" not "added feature" or "adds feature"
4. **No period at the end** of the summary line
5. **Separate subject from body** with a blank line if including a longer description
6. **Wrap body text** at 72 characters
7. **Explain the what and why**, not the how

## Examples

Good commit messages:
```
feat: add user authentication system

fix: resolve null pointer exception in login form

refactor: simplify data processing pipeline

style: standardize indentation in CSS files

chore: update dependencies in Cargo.toml

test: add unit tests for password validation

docs: update API documentation with examples

perf: optimize database query for user search
```

Remember that a good commit message helps other developers (and future you) understand the context and purpose of changes without having to review the code itself.

]]

return {
  {
    "github/copilot.vim",
    enabled = true,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = true,
    lazy = false,
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      model = "claude-3.7-sonnet",
      prompts = {
        Commit = {
          prompt = commit_prompt,
          context = 'git:staged',
        },
      },
    },
    keys = {
      {
        "<leader>cm",
        "<cmd>CopilotChatCommit<cr>",
        desc = "CopilotChat - Commit",
      }
    }
  },
}
