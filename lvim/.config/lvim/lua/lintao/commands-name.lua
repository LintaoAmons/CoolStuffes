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

    ToCamelCase = "ToCamelCase",
    ToConstantCase = "ToConstantCase",
    ToKebabCase = "ToKebabCase",
    ToSnakeCase = "ToSnakeCase",
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
    MarkNext = "MarkNext",
    MarkPrev = "MarkPrev",
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
  run = {
    RunCurrentBuffer = "RunCurrentBuffer",
    RunLiveToggle = "RunLiveToggle",
  },
  other = {
    QuitNvim = "QuitNvim",
    DiffWithClipboard = "DiffWithClipboard",
    FormatCode = "FormatCode",
    NoHighlight = "NoHighlight",
    ToggleOutline = "ToggleOutline",
    CloseWindowOrBuffer = "CloseWindowOrBuffer",
    CopyBufAbsPath = "CopyBufAbsPath",
    CopyBufAbsDirPath = "CopyBufAbsDirPath",
    CopyProjectDir = "CopyProjectDir",
    CopyBufRelativePath = "CopyBufRelativePath",
    CopyBufRelativeDirPath = "CopyBufRelativeDirPath",
  },
  nvim = {
    SourceCurrentBuffer = "SourceCurrentBuffer",
  }
}
