return {
  git = {
    GitDiff = "GitDiff",
    GitCommit = "GitCommit",
    GitStash = "GitStash",
    GitPush = "GitPush",
    GitListCommits = "GitListCommits",
    GitListCurrentFileCommits = "GitListCurrentFileCommits",
    GitNextHunk = "GitNextHunk",
    GitPrevHunk = "GitPrevHunk",
    GitResetHunk = "GitResetHunk",
    GitListBranches = "GitListBranches",
    GitChangedFiles = "GitChangedFiles",
  },
  refactor = {
    ExtractFunction = "ExtractFunction",
    ExtractVariable = "ExtractVariable",
    InlineVariable = "InlineVariable",
  },
  explorer = {
    ExplorerLocateCurrentFile = "ExplorerLocateCurrentFile",
  },
  navigation = {
    OpenChangedFiles = "OpenChangedFiles",
    OpenRecentFiles = "OpenRecentFiles",
    LeapJump = "LeapJump",
    MaximiseBuffer = "MaximiseBuffer",

    TabNext = "TabNext",
    TabPrev = "TabPrev",
    TabClose = "TabClose",
    TabNew = "TabNew",

    BufferNext = "BufferNext",
    BufferPrev = "BufferPrev",

    SplitVertically = "SplitVertically",
    MaximiseBufferAndCloseOthers = "MaximiseBufferAndCloseOthers",
    IncreaseSplitWidth = "IncreaseSplitWidth",
    DecreaseSplitWidth = "DecreaseSplitWidth",

    Mark = "Mark",
    MarkJump = "MarkJump",
  },
  test = {
    TestRunNearest = "TestRunNearest",
    TestRunCurrentFile = "TestRunCurrentFile", -- TODO
    TestRunLast = "TestRunLast",
    TestToggleOutputPanel = "TestToggleOutputPanel",
    TestDebugNearest = "TestDebugNearest",
    TestOutputPanel = "TestOutputPanel",
    GoToTestFile = "GoToTestFile",
  },
  finder = {
    FindFiles = "FindFiles",
    FindCommands = "FindCommands",
    FindKeymappins = "FindKeymappins",
    FindInWholeProject = "FindInWholeProject",
    FzfLuaBuiltin = "FzfLuaBuiltin",
  },
  scratch = {
    Scratch = "Scratch",
    ScratchOpen = "ScratchOpen",
  },
  other = {
    QuitNvim = "QuitNvim",
    DiffWithClipboard = "DiffWithClipboard",
    RunCurrentBuffer = "RunCurrentBuffer",
    FormatCode = "FormatCode",
    NoHighlight = "NoHighlight",
    ToggleOutline = "ToggleOutline",
    ToggleTerminal = "ToggleTerminal", -- TODO
    CloseWindowOrBuffer = "CloseWindowOrBuffer",
    CopyBufferAbsolutePath = "CopyBufferAbsolutePath",
    CopyBufferDirectoryPath = "CopyBufferDirectoryPath",
    CopyBufferAbsolutePathFromProjectRoot = "CopyBufferAbsolutePathFromProjectRoot",   -- TODO
    CopyBufferDirectoryPathFromProjectRoot = "CopyBufferDirectoryPathFromProjectRoot", -- TODO
  },
  nvim = {
    SourceCurrentBuffer = "SourceCurrentBuffer",
  }
}
