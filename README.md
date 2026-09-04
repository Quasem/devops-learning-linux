# 🐧 Linux Fundamentals — Learning Journal

> My personal notes and progress log from learning Linux as part of my journey transitioning from **QA Engineer → Cloud Engineer**.
> Studying with [CoderCo](https://coderco.io) | Practising on [KillerCoda](https://killercoda.com) | Challenges on [OverTheWire Bandit](https://overthewire.org/wargames/bandit/)

---

## 📋 Table of Contents

- [Module 1 — Linux Fundamentals](#module-1--linux-fundamentals)
  - [Shells](#shells)
  - [Essential File Commands](#essential-file-commands)
  - [Directory Commands](#directory-commands)
  - [Vim Editor](#vim-editor)
  - [Users, Sudo and Root](#users-sudo-and-root)
  - [File Permissions](#file-permissions)
  - [Data Streams and Redirection](#data-streams-and-redirection)
  - [Environment Variables](#environment-variables)
  - [Aliases](#aliases)
- [OverTheWire Bandit — CTF Progress](#overthewire-bandit--ctf-progress)
  - [Levels Completed](#levels-completed)
  - [Key Commands Learned Per Level](#key-commands-learned-per-level)
- [Key Takeaways](#key-takeaways)
- [Resources](#resources)

---

## Module 1 — Linux Fundamentals

### Shells

A **shell** is the command-line interface between you and the operating system. Different shells have slightly different syntax and features.

| Shell | Notes |
|-------|-------|
| `bash` | Bourne Again Shell — the most common default on Linux |
| `zsh` | Extended features, popular with developers (default on macOS) |
| `ksh` | Korn Shell — common in enterprise Unix environments |
| `fish` | Friendly Interactive Shell — beginner-friendly with auto-suggestions |
| `csh` | C Shell — syntax resembles the C programming language |

> 💡 To check which shell you're currently using: `echo $SHELL`

---

### Essential File Commands

| Command | Description | Example |
|---------|-------------|---------|
| `touch` | Create an empty file | `touch myfile.txt` |
| `echo` | Print text or write to a file | `echo "hello" > file.txt` |
| `cat` | Read and display file contents | `cat myfile.txt` |
| `head` | Show the first N lines of a file (default 10) | `head -n 5 file.txt` |
| `tail` | Show the last N lines of a file | `tail -n 5 file.txt` |
| `cp` | Copy a file | `cp file.txt backup.txt` |
| `cp -r` | Copy an entire directory recursively | `cp -r myfolder/ backup/` |
| `mv` | Move or rename a file | `mv oldname.txt newname.txt` |
| `rm` | Remove a file | `rm file.txt` |
| `rm -r` | Remove a directory and its contents | `rm -r myfolder/` |
| `whoami` | Show the current logged-in user | `whoami` |

> ⚠️ `rm` has **no recycle bin**. Deleted files are gone permanently. Always double-check before running.

---

### Directory Commands

| Command | Description | Example |
|---------|-------------|---------|
| `mkdir` | Create a new directory | `mkdir projects` |
| `mkdir -p` | Create nested directories in one command | `mkdir -p projects/cloud/aws` |
| `rmdir` | Remove an **empty** directory | `rmdir oldfolder` |
| `rm -rf` | Remove a directory and everything inside it (use with extreme caution) | `rm -rf myfolder/` |

> ☠️ **`rm -rf /`** is one of the most dangerous commands in Linux. It attempts to delete **everything** on the system from the root down. Never run this.

---

### Vim Editor

Vim is a powerful terminal-based text editor. It confused me at first — now I understand why: it has **modes**.

#### The Three Modes

| Mode | How to enter | What it does |
|------|-------------|--------------|
| **Command mode** | Default when Vim opens / press `Esc` | Navigate, delete, copy — no typing |
| **Insert mode** | Press `i` | Type and edit text as normal |
| **Visual mode** | Press `v` | Select text for copying or deletion |

#### Essential Vim Commands

```
i           → Enter Insert mode (start typing)
Esc         → Return to Command mode
:w          → Save the file
:q          → Quit Vim
:wq         → Save and quit
:q!         → Quit without saving (force quit)
dd          → Delete the current line
yy          → Copy (yank) the current line
p           → Paste
```

> 💡 **Quick tip:** If you ever get stuck in Vim, press `Esc` then type `:q!` and hit Enter. This exits without saving.

---

### Users, Sudo and Root

#### The `sudo` Command

`sudo` stands for **Super User Do**. It temporarily grants you elevated (root-level) permissions to run a single command.

```bash
sudo apt update           # Run a command as root
whoami                    # Shows current user
sudo whoami               # Shows "root"
```

> 🔍 **Important:** Every `sudo` command is **logged** by the system. You can see the full history with:

```bash
sudo tail /var/log/auth.log
```

This is a critical security feature in Linux — privileged actions always leave an audit trail.

#### Managing Users

```bash
sudo useradd username         # Create a new user
sudo passwd username          # Set a password for the user
sudo deluser username         # Delete a user
sudo usermod -aG sudo username  # Add user to the sudo group
sudo deluser username sudo    # Remove user from the sudo group
```

#### Groups

Groups allow you to manage permissions for multiple users at once. A user can belong to many groups.

```bash
groups username               # See which groups a user belongs to
```

---

### File Permissions

This was one of the most important things I learned. Linux controls who can do what to every single file.

#### Permission Structure

Every file has three sets of permissions assigned to three types of user:

```
rwx  rwx  rwx
 |    |    |
 |    |    └── Other (everyone else)
 |    └─────── Group
 └──────────── Owner (User)
```

Each permission:
- `r` = Read (value: **4**)
- `w` = Write (value: **2**)
- `x` = Execute (value: **1**)
- `-` = No permission (value: **0**)

#### Octal (Numeric) Notation

Permissions are often expressed as a 3-digit number. Each digit is the **sum** of the permissions for that role.

| Binary | Octal | Permissions |
|--------|-------|-------------|
| `000`  | `0`   | `---` (none) |
| `001`  | `1`   | `--x` (execute only) |
| `100`  | `4`   | `r--` (read only) |
| `110`  | `6`   | `rw-` (read + write) |
| `111`  | `7`   | `rwx` (full access) |

#### Example: `chmod 744`

```
7  4  4
|  |  |
|  |  └── Other:  r-- (read only)
|  └───── Group:  r-- (read only)
└──────── Owner:  rwx (full access)
```

#### Changing Permissions with `chmod`

```bash
chmod 755 script.sh           # Numeric method
chmod u=rwx,g=rx,o=rx file   # Symbolic method
chmod ug=rw,o=r file         # Set read/write for owner & group, read for others
```

#### Changing Ownership

```bash
sudo chown newowner file.txt          # Change file owner
sudo chgrp newgroup file.txt          # Change file group
sudo chown owner:group file.txt       # Change both at once
```

> 💡 Use a [chmod calculator](https://chmodcommand.com/) to visualise permissions until the numbers become second nature.

---

### Data Streams and Redirection

Linux has three standard data streams:

| Stream | Number | Description |
|--------|--------|-------------|
| `stdin` | `0` | Standard input (keyboard by default) |
| `stdout` | `1` | Standard output (terminal by default) |
| `stderr` | `2` | Standard error (terminal by default) |

#### Redirection Operators

```bash
command > file.txt      # Redirect stdout to a file (overwrites)
command >> file.txt     # Redirect stdout to a file (appends)
command 2> errors.txt   # Redirect stderr to a file
command 2>/dev/null     # Discard error messages completely
command &> output.txt   # Redirect both stdout and stderr
```

#### What is `/dev/null`?

`/dev/null` is a special Linux file that **discards everything written to it**. It is used to suppress unwanted output — especially error messages — so your terminal stays clean.

```bash
find / -name "secret" 2>/dev/null    # Suppress "Permission denied" errors
```

---

### Environment Variables

Environment variables are key-value pairs that store system-wide configuration and are available to all processes and scripts.

#### Common Built-in Variables

| Variable | What it holds |
|----------|--------------|
| `$HOME` | Your home directory path |
| `$PATH` | Directories Linux searches for commands |
| `$USER` | Current logged-in username |
| `$SHELL` | Path to your current shell |
| `$EDITOR` | Your default text editor |

#### Using Environment Variables

```bash
echo $HOME              # Print your home directory
echo $PATH              # See where Linux looks for executables
export MY_VAR="hello"  # Create a custom environment variable
echo $MY_VAR            # Print it
```

#### Configuration Files

| File | Shell | Purpose |
|------|-------|---------|
| `~/.bashrc` | bash | Runs every time a bash terminal opens |
| `~/.zshrc` | zsh | Runs every time a zsh terminal opens |

These files are where you store permanent environment variables, aliases, and settings.

```bash
source ~/.zshrc         # Reload your config file without restarting the terminal
```

---

### Aliases

Aliases let you create shortcuts for long or frequently-used commands.

```bash
alias ll='ls -la'                    # List files with details
alias gs='git status'               # Shortcut for git status
alias ..='cd ..'                    # Go up one directory

# To make aliases permanent, add them to ~/.bashrc or ~/.zshrc
```

```bash
alias                               # List all currently active aliases
source ~/.zshrc                     # Reload after adding new aliases
```

---

## OverTheWire Bandit — CTF Progress

[Bandit](https://overthewire.org/wargames/bandit/) is a capture-the-flag (CTF) game designed to teach Linux command-line skills through increasingly difficult challenges. Each level gives you a password to find — which you use to SSH into the next level.

**Current progress: Level 20 ✅**

---

### Levels Completed

| Level | Status | Key skill practised |
|-------|--------|-------------------|
| 0 → 1 | ✅ | SSH login, `cat` |
| 1 → 2 | ✅ | Reading files with special names (dash prefix) |
| 2 → 3 | ✅ | Files with spaces in the name |
| 3 → 4 | ✅ | Hidden files with `ls -a` |
| 4 → 5 | ✅ | `file` command to identify file types |
| 5 → 6 | ✅ | `find` with multiple filters (`-size`, `! -executable`) |
| 6 → 7 | ✅ | System-wide `find` with user/group filters + `2>/dev/null` |
| 7 → 8 | ✅ | `grep` to search inside files |
| 8 → 9 | ✅ | `sort` + `uniq -u` to find unique lines |
| 9 → 10 | ✅ | `strings` + `grep` to extract human-readable content from binary |
| 10 → 11 | ✅ | `base64 -d` to decode base64 encoded data |
| 11 → 12 | ✅ | `tr` to decode ROT13 cipher |
| 12 → 13 | ✅ | `xxd -r`, `file`, `gunzip`, `bunzip2`, `tar` — recursive decompression |
| 13 → 14 | ✅ | SSH with private key authentication (`ssh -i`, `scp`, `chmod 600`) |
| 14 → 15 | ✅ | Netcat (`nc`) — sending data to a network port |
| 15 → 16 | ✅ | `openssl s_client` — encrypted SSL/TLS connections |
| 16 → 17 | ✅ | `nmap` port scanning, extracting and decoding SSH private keys |
| 17 → 18 | ✅ | `diff` — comparing files to find changed lines |
| 18 → 19 | ✅ | Bypassing `.bashrc` trap with remote SSH command execution |
| 19 → 20 | ✅ | SetUID binaries — running commands as another user |

---

### Key Commands Learned Per Level

#### Level 0 → 1 — SSH and reading files
```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
cat readme
```

#### Level 1 → 2 — Files with a dash in the name
```bash
# A file named "-" confuses cat — use ./ to specify it's a path, not a flag
cat ./-
```

#### Level 2 → 3 — Files with spaces in the name
```bash
# Wrap the filename in quotes
cat "./spaces in this filename"
```

#### Level 3 → 4 — Hidden files
```bash
# ls doesn't show hidden files by default — use -a flag
ls -a
cat ...Hiding-From-You
```

#### Level 4 → 5 — Identifying file types
```bash
# The file command reads "magic bytes" to identify what a file really is
file ./-*
cat ./-file07      # Only file07 was ASCII text
```

#### Level 5 → 6 — Finding files by properties
```bash
# Find a file that is exactly 1033 bytes and not executable
find inhere -type f -size 1033c ! -executable
```

#### Level 6 → 7 — Searching the whole system
```bash
# Search entire filesystem, filter by owner, group and size
# Redirect errors to /dev/null to keep output clean
find / -user bandit7 -group bandit6 -size 33c 2>/dev/null
```

#### Level 7 → 8 — Searching inside files
```bash
# grep searches a file for lines containing a specific word
grep "millionth" data.txt
```

#### Level 8 → 9 — Finding the unique line
```bash
# sort first (uniq only works on adjacent lines), then filter to lines appearing once
sort data.txt | uniq -u
```

#### Level 9 → 10 — Extracting readable strings from binary
```bash
# strings extracts printable text from binary, grep filters for lines with "=="
strings data.txt | grep "=="
```

#### Level 10 → 11 — Decoding base64
```bash
# -d flag decodes base64 encoded content
base64 -d data.txt
```

#### Level 11 → 12 — Decoding ROT13
```bash
# tr translates character sets — ROT13 shifts each letter by 13 positions
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

#### Level 12 → 13 — Recursive decompression (the hardest level so far)

This level had a file that had been compressed multiple times using different tools. The trick was to:
1. Convert the hexdump back to binary with `xxd -r`
2. Use `file` to identify the compression type
3. Rename the file with the correct extension
4. Decompress it
5. Repeat until you reach a plain text file

```bash
cd $(mktemp -d)              # Create a safe working directory
cp ~/data.txt .              # Copy the file to work with
xxd -r data.txt > data       # Convert hexdump back to binary

# Then repeatedly:
file data                    # What type is it?
mv data data.gz              # Rename with correct extension
gunzip data.gz               # Decompress gzip
# or
bunzip2 data.bz2             # Decompress bzip2
# or
tar -xf data.tar             # Extract tar archive

# Repeat until:
# data: ASCII text
cat data                     # Read the password
```

**Tools used in this level:**

| Tool | Purpose |
|------|---------|
| `xxd -r` | Convert hexdump text back to binary |
| `file` | Identify file type from magic bytes |
| `mv` | Rename file with correct extension |
| `gunzip` | Decompress `.gz` files |
| `bunzip2` | Decompress `.bz2` files |
| `tar -xf` | Extract `.tar` archives |

#### Level 13 → 14 — SSH authentication with a private key

Instead of a password, this level provided a private SSH key file. This is how most real-world server authentication works in cloud environments.

```bash
# Step 1: Inside bandit13, list the key file
ls -l
# Shows: sshkey.private

# Step 2: Download the key to your local machine using Secure Copy
scp -P 2220 bandit13@bandit.labs.overthewire.org:sshkey.private ./sshkey.private

# Step 3: Fix permissions — SSH WILL REFUSE a private key that is too open
chmod 600 ./sshkey.private

# Step 4: Connect using the key with the -i (identity file) flag
ssh -i ./sshkey.private bandit14@bandit.labs.overthewire.org -p 2220

# Step 5: Once logged in as bandit14, read the password
cat /etc/bandit_pass/bandit14
```

**Why `chmod 600` is required:**
SSH strictly rejects private key files that are readable by other users. `600` means only the owner can read and write — nobody else can touch it. This is a security enforcement, not just a convention.

| Command | Purpose |
|---------|---------|
| `scp -P 2220` | Securely copy a file from a remote server (note capital `-P` for port) |
| `chmod 600` | Restrict file to owner read/write only — required by SSH |
| `ssh -i keyfile` | Use a private key file instead of a password to authenticate |

> ☁️ **Cloud relevance:** Private key authentication is the standard way to access cloud servers (AWS EC2, GCP VMs). You will use `ssh -i` constantly as a cloud engineer.

---

#### Level 14 → 15 — Netcat: sending data to a network port

The password was retrieved by submitting the current level's password to a service listening on port 30000 of localhost.

```bash
# Pipe the password directly into netcat, which sends it to the port
echo "aaWecNkG4FhxJQxz07uiwzVP6bJiYS65" | nc localhost 30000

# Server responds: Correct! pbLYuZtTg4MgaqfJx8jbA9gKKGqM68A7
```

**What `nc` (Netcat) does:**
Netcat opens a raw TCP or UDP connection to any IP and port. It sends whatever you pipe into it and prints whatever the server sends back. It is known as the "Swiss Army knife" of networking tools.

**Why not use other tools here?**

| Tool | Why not used here |
|------|------------------|
| `telnet` | Older, less flexible — nc is the modern standard |
| `nmap` | For scanning ports, not sending data |
| `openssl` | For encrypted SSL connections — port 30000 used plain text |
| `nc` | ✅ Correct — fast, simple, unencrypted plain text |

> ☁️ **Cloud relevance:** Network engineers use `nc` to test whether ports are open and services are responding before deploying applications.

---

#### Level 15 → 16 — OpenSSL: encrypted connections

Port 30001 required SSL/TLS encryption — plain `nc` fails here because it sends unencrypted text.

```bash
# Method 1: Interactive — connect, wait for prompt, then paste password
openssl s_client -connect localhost:30001

# Method 2: One-liner pipe (cleaner)
# -ign_eof prevents the connection closing before the server can reply
echo "pbLYuZtTg4MgaqfJx8jbA9gKKGqM68A7" | openssl s_client -connect localhost:30001 -ign_eof
```

**Why `openssl s_client`?**
`nc` sends plain text. `openssl s_client` creates an encrypted SSL/TLS tunnel first, then sends your data through it — exactly like HTTPS does in a browser.

> ☁️ **Cloud relevance:** SSL/TLS is the foundation of HTTPS and secure API communication. Understanding how encrypted connections work at this level is essential for cloud security.

---

#### Level 16 → 17 — Port scanning with nmap and extracting SSH keys

This level required finding which port in a range was actually running an SSL service, then using it to retrieve a private SSH key.

```bash
# Step 1: Scan ports 31000-32000 to find which ones have services running
nmap -sV -p 31000-32000 localhost
# Result: port 31790 is the active SSL service

# Step 2: Submit the password to that port and extract the returned SSH private key
cat /etc/bandit_pass/bandit16 | openssl s_client -connect localhost:31790 -quiet 2>/dev/null \
  | sed -n '/-----BEGIN OPENSSH/,/-----END OPENSSH/p' \
  | base64 -w 0

# Step 3: On your local machine, decode the key and save it
echo "PASTE_BASE64_HERE" | base64 -d > key17

# Step 4: Fix permissions
chmod 600 key17

# Step 5: Connect to bandit17 using the key
ssh -i key17 bandit17@bandit.labs.overthewire.org -p 2220

# Step 6: Read the password
cat /etc/bandit_pass/bandit17
```

**Why base64 encode the key?**
Copying a multi-line SSH private key between terminals can introduce line-break corruption. Converting it to a single base64 string first, then decoding it on the other end, ensures the key arrives intact.

| Tool | Purpose |
|------|---------|
| `nmap -sV` | Scan a port range and detect what service is running |
| `sed -n '/pattern/,/pattern/p'` | Extract lines between two markers |
| `base64 -w 0` | Encode to base64 with no line wrapping |
| `base64 -d` | Decode base64 back to original content |

> ☁️ **Cloud relevance:** `nmap` is a fundamental tool for security audits and network reconnaissance in cloud infrastructure.

---

#### Level 17 → 18 — The `diff` command: comparing files

Two files (`passwords.old` and `passwords.new`) contained thousands of lines. Only one line changed — that changed line was the password.

```bash
# diff compares two files and shows exactly what changed
diff passwords.old passwords.new

# Output:
# 42c42
# < q0g5...   ← old line (from passwords.old)
# ---
# > 0QxX...   ← new line (from passwords.new) — this is the password
```

**Reading `diff` output:**

| Symbol | Meaning |
|--------|---------|
| `42c42` | Line 42 in file 1 was **c**hanged on line 42 in file 2 |
| `<` | Line from the **first** file (old) |
| `>` | Line from the **second** file (new) |
| `---` | Visual separator between the two versions |

> ☁️ **Cloud relevance:** `diff` is what powers `git diff` under the hood. Cloud engineers use it constantly to compare config files (Kubernetes YAMLs, Nginx configs, Terraform files) when debugging environment changes.

---

#### Level 18 → 19 — Bypassing a `.bashrc` login trap

Logging in normally caused an immediate disconnect with `Byebye!`. The `.bashrc` file had been modified to run `exit` the moment a login shell started.

```bash
# Normal login fails — .bashrc runs exit immediately
ssh bandit18@bandit.labs.overthewire.org -p 2220
# → "Byebye !"

# Fix: append a command to SSH — this runs the command WITHOUT starting a login shell
# so .bashrc never executes
ssh bandit18@bandit.labs.overthewire.org -p 2220 cat readme
# → Kps0fPkcP7i1FLIExk2QEjyt6dw8dxZI

# Alternative: force bash to start without reading config files
ssh -t bandit18@bandit.labs.overthewire.org -p 2220 /bin/bash --norc
```

**Why this works:**
When SSH receives a command appended to the connection string, it executes that binary directly without spawning an interactive login shell. No login shell = `.bashrc` never runs = trap never triggers.

| Flag | Purpose |
|------|---------|
| `ssh host command` | Run a single command on the remote server without a login shell |
| `-t` | Force pseudo-terminal allocation |
| `--norc` | Start bash without reading `.bashrc` or `.bash_profile` |

> ☁️ **Cloud relevance:** Running remote commands via SSH without a full shell session is common in automation scripts, CI/CD pipelines, and deployment tools like Ansible.

---

#### Level 19 → 20 — SetUID binaries: running as another user

A special binary (`bandit20-do`) was in the home directory. The challenge was understanding what SetUID permission means and how to exploit it.

```bash
# Step 1: Inspect the binary's permissions
ls -la
# → -rwsr-x--- 1 bandit20 bandit19 ... bandit20-do
#       ^ The 's' here means SetUID is set

# Step 2: Test what user the binary runs as
./bandit20-do id
# → uid=11019(bandit19) gid=11019(bandit19) euid=11020(bandit20)
#   euid = effective user ID — the binary temporarily runs as bandit20

# Step 3: Use that temporary bandit20 access to read the protected password file
./bandit20-do cat /etc/bandit_pass/bandit20
```

**What is SetUID?**

The `s` in `-rwsr-x---` stands for **SetUID (Set User ID)**. It tells Linux:

> "When anyone runs this binary, temporarily grant them the effective permissions of the **file's owner**, not the person running it."

In this case, the file is owned by `bandit20` — so anyone who runs it gains `bandit20`'s permissions for the duration of that process.

```
-rwsr-x---
    ^
    s = SetUID bit — execute as the file OWNER, not the caller
```

| Term | Meaning |
|------|---------|
| `uid` | Real user ID (who you actually are) |
| `euid` | Effective user ID (who the process runs as) |
| SetUID | Special permission bit that sets `euid` to the file owner's ID |

> ⚠️ **Security note:** SetUID binaries are a significant attack surface. A badly written SetUID binary can be exploited to gain root access. Cloud security engineers audit systems for unexpected SetUID files with: `find / -perm -4000 2>/dev/null`

> ☁️ **Cloud relevance:** Understanding privilege escalation through SetUID is core knowledge for cloud security, DevSecOps roles, and any security certification (CompTIA Security+, AWS Security Specialty).

---

## Key Takeaways

These are the things that genuinely shifted my understanding:

1. **`sudo` is audited** — every privileged command is logged. In production, this matters enormously for security and compliance.

2. **Linux doesn't use file extensions to identify files** — the `file` command reads magic bytes inside the file. This completely changed how I think about files.

3. **`/dev/null` is your friend** — redirecting errors there keeps output clean. `2>/dev/null` is something you'll use constantly in scripts.

4. **Vim has modes, not a bug** — once I understood Command, Insert and Visual mode, Vim went from terrifying to logical.

5. **File permissions are just binary** — `rwx = 111 = 7`, `rw- = 110 = 6`, `r-- = 100 = 4`. Once you see the binary, the octal numbers make complete sense.

6. **Piping is incredibly powerful** — chaining commands with `|` is fundamental to how Linux is designed. `sort data.txt | uniq -u` is a good example of doing something complex with simple tools chained together.

7. **Private key authentication is the real-world standard** — passwords are rarely used to access cloud servers. `ssh -i keyfile` with a `chmod 600` key is how you connect to AWS EC2, GCP VMs, and most production infrastructure.

8. **`diff` powers everything** — `git diff`, config auditing, deployment validation. It is one of the most useful tools a cloud engineer can know deeply.

9. **`.bashrc` runs on every login shell** — and that means it can be used as both a productivity tool and, as Bandit showed, a trap. Understanding the login shell lifecycle matters for automation and scripting.

10. **SetUID is powerful and dangerous** — the `s` permission bit lets a binary run as its owner, not the caller. This is how some Linux tools gain elevated access safely — and how attackers escalate privileges when it is misconfigured. Always audit with `find / -perm -4000 2>/dev/null` on a new system.

11. **Networking tools are a cloud engineer's daily toolkit** — `nc` for testing ports, `openssl s_client` for encrypted connections, `nmap` for scanning. These are not just CTF tools — they are real diagnostic tools used in production environments every day.

---

## Resources

| Resource | Description |
|----------|-------------|
| [KillerCoda](https://killercoda.com) | Free browser-based Linux environment — no setup needed |
| [OverTheWire Bandit](https://overthewire.org/wargames/bandit/) | CTF game for learning Linux through challenges |
| [CoderCo](https://coderco.io) | Cloud engineering training and career support |
| [Chmod Calculator](https://chmodcommand.com/) | Visual tool for understanding file permissions |
| [Explain Shell](https://explainshell.com) | Paste any Linux command and get an explanation of each part |
| [Linux Journey](https://linuxjourney.com) | Free interactive Linux learning course |

---

*Learning in public as part of my QA → Cloud Engineering transition. Connect with me on [LinkedIn](https://www.linkedin.com/in/qas-khandker/).*
