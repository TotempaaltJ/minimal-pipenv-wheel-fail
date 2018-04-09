import sys

try:
    import dep
except ImportError as e:
    print("  💥  ImportError:", e)
    sys.exit(1)

print("  🎉  Ran successfully!")
