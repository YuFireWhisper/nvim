local commit_prompt = [[
# Commit Message Guide

## Format
<type>: <short summary>
[blank line]
[optional bullet points for details]

## Types
- `feat`: New features/functionality
- `fix`: Bug fixes
- `refactor`: Code restructuring (no new features/fixes)
- `style`: Format changes (whitespace, indentation)
- `chore`: Maintenance tasks, dependencies, config
- `test`: Adding/modifying tests
- `docs`: Documentation changes
- `perf`: Performance improvements

## Best Practices
1. Keep summary under 50 characters
2. Use imperative mood ("add" not "added")
3. Be specific about what changed
4. No period at end of summary
5. Wrap body text at 72 characters
6. Explain what and why, not how

## Details Format
- If including details, start each point with a hyphen (-)
- Details are optional
- Example:
feat: add user authentication system
- Implement JWT token generation
- Add password hashing with bcrypt

## Examples
feat: implement user authentication system
fix: resolve null pointer in login form
refactor: simplify data processing pipeline
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
      { "nvim-telescope/telescope.nvim" },
    },
    opts = {
      model = "claude-sonnet-4",
      prompts = {
        Commit = {
          prompt = commit_prompt,
          context = 'git:staged',
        },
      },
      integrations = {
        telescope = true,
      },
      selection = function(_)
        return nil
      end
    },
    keys = {
      {
        "<leader>cc",
        "<cmd>CopilotChat<cr>",
        desc = "Open CopilotChat",
      },
      {
        "<leader>cm",
        "<cmd>CopilotChatCommit<cr>",
        desc = "CopilotChat - Commit",
      }
    }
  },
}
