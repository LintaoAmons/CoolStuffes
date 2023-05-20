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
    GitSomething = "GitSomething", -- TODO
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
  },
  test = {
    TestRunNearest = "TestRunNearest",
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
  },
  nvim = {
    SourceCurrentBuffer = "SourceCurrentBuffer",
  }
}
