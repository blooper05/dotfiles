Write How in code,
What in test code,
Why in commit logs,
and Why not in code comments,
following [t-wada's principle](https://x.com/t_wada/status/904916106153828352):

> コードには How テストコードには What コミットログには Why コードコメントには Why not を書こう

How means self-explanatory code:
rewrite unclear code instead of explaining it in comments.
What means expected behavior:
assert what callers observe, not how the code works inside.
Why means the reason for the change:
the diff already shows what changed.
Why not means rejected alternatives:
constraints, failed approaches, and warnings to future editors.
