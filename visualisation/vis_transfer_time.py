import matplotlib.pyplot as plt
import numpy as np
import re
import statistics as stats

ftppath = "D:\\Uni\\Thesis\\Code\\new\\stmonitor\\remote_logs\\transfertime4\\"
splitftppath = "D:\\Uni\\Thesis\\Code\\new\\stmonitor\\remote_logs\\split\\transfertime4\\"


# ftppath = "D:\\Uni\\Thesis\\Code\\new\\stmonitor\\scripts\\ftp\\logs\\time\\"
# splitftppath = "D:\\Uni\\Thesis\\Code\\new\\stmonitor\\scripts\\splitftp\\logs\\time\\"


def plot_transfer_time(filename, sizestr, actionstr):
    filepath = (splitftppath if "split" in filename else ftppath) + filename
    file = open(filepath, 'r')
    data = [float(t) for t in file.read().split(',')[:-1]]
    file.close()

    colour = 'g' if "split" in filename else ('r' if "mon" in filename else 'c')
    name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "mon" in filename else 'Control')
    plt.plot(np.arange(1, len(data)+1, 1), data, colour, label=name + "; Min: " + str(round(min(data), 6)))
    plt.xlabel('Iterations')
    plt.ylabel("Transfer Time")
    plt.title("Transfer time of " + sizestr + " file " + actionstr + " over 20000 iterations")
    plt.legend()
    test = 'split' if "split" in filename else ('mon' if "mon" in filename else 'control')
    plt.savefig("single-"+test+"-"+sizestr+"-"+actionstr+".png")
    plt.show()


def plot_minimums(filename, sizestr, actionstr, step):
    filepath = (splitftppath if "split" in filename else ftppath) + filename
    file = open(filepath, 'r')
    data = [float(t) for t in file.read().split(',')[:-1]]
    file.close()
    
    mins = [min(data[i*step:(i+1)*step]) for i in range(int(len(data)/step))]

    colour = 'g' if "split" in filename else ('r' if "mon" in filename else 'c')
    name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "mon" in filename else 'Control')
    plt.plot(np.arange(1, len(data)+1, step), mins, colour, label=name + "; Min: " + str(round(min(mins), 6)))
    plt.xlabel('Iterations')
    plt.ylabel("Transfer Time")
    plt.title("Transfer time of " + sizestr + " file " + actionstr + " over 20000 iterations")
    plt.legend()
    plt.show()


def plot_three(filenames, sizestr, actionstr):
    for filename in filenames:
        filepath = (splitftppath if "split" in filename else ftppath) + filename
        file = open(filepath, 'r')
        data = [float(t) for t in file.read().split(',')[:-1]]
        file.close()

        # mins = [min(data[i*step:(i+1)*step]) for i in range(int(len(data)/step))]

        colour = 'g' if "split" in filename else ('r' if "mon" in filename else 'c')
        name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "mon" in filename else 'Control')
        plt.plot(np.arange(1, len(data)+1, 1), data, colour, label=name + "; Min: " + str(round(min(data), 6)))
    plt.xlabel('Iterations')
    plt.ylabel("Transfer Time")
    plt.title("Transfer time of " + sizestr + " file " + actionstr + " over 20000 iterations")
    plt.legend()
    plt.show()


def plot_three_mins(filenames, sizestr, actionstr, step):
    for filename in filenames:
        filepath = (splitftppath if "split" in filename else ftppath) + filename
        file = open(filepath, 'r')
        data = [float(t) for t in file.read().split(',')[:-1]]
        file.close()

        mins = [min(data[i*step:(i+1)*step]) for i in range(int(len(data)/step))]

        colour = 'g' if "split" in filename else ('r' if "mon" in filename else 'c')
        name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "mon" in filename else 'Control')
        plt.plot(np.arange(1, len(data)+1, step), mins, colour, label=name + "; Min: " + str(round(min(mins), 6)))
    plt.xlabel('Iterations')
    plt.ylabel("Transfer Time")
    plt.title("Transfer time of " + sizestr + " file " + actionstr + " over 20000 iterations")
    plt.legend()
    plt.savefig("mins-"+sizestr+"-"+actionstr+".png")
    plt.show()


def plot_histogram(filename, sizestr, actionstr):
    filepath = (splitftppath if "split" in filename else ftppath) + filename
    file = open(filepath, 'r')
    data = [float(t) for t in file.read().split(',')[:-1]]
    file.close()

    # mins = [min(data[i * step:(i + 1) * step]) for i in range(int(len(data) / step))]

    colour = 'g' if "split" in filename else ('r' if "mon" in filename else 'c')
    name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "mon" in filename else 'Control')
    bins = np.linspace(0, 0.04, 100)

    plt.hist(data, bins, alpha=0.5, label=name, color=colour)
    plt.xlabel('Transfer Time (s)')
    plt.title("Transfer time of " + sizestr + " file " + actionstr + " over 20000 iterations")
    plt.legend()
    plt.show()


def plot_histograms(filenames, sizestr, actionstr):
    bins = np.linspace(0, 0.025, 100) if sizestr is "large" else (np.linspace(0, 0.003, 100) if sizestr is "med" else np.linspace(0, 0.001, 100))
    for filename in filenames:
        filepath = (splitftppath if "split" in filename else ftppath) + filename
        file = open(filepath, 'r')
        data = [float(t) for t in file.read().split(',')[:-1]]
        file.close()

        # mins = [min(data[i * step:(i + 1) * step]) for i in range(int(len(data) / step))]

        colour = 'g' if "split" in filename else ('r' if "mon" in filename else 'c')
        name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "mon" in filename else 'Control')

        plt.hist(data, bins, alpha=0.5, label=name + "; Median: " + str(round(stats.median(data), 6)), color=colour)
    plt.xlabel('Transfer Time (s)')
    plt.ylabel('Frequency')
    plt.title("Transfer time of " + sizestr + " file " + actionstr + " over 20000 iterations")
    plt.legend()
    plt.savefig("hist-"+sizestr+"-"+actionstr+".png")
    plt.show()


labels = ["tr-small.txt", "tw-small.txt", "tr-med.txt", "tw-med.txt", "tr-large.txt", "tw-large.txt",
          "tr-small-mon.txt", "tw-small-mon.txt", "tr-med-mon.txt", "tw-med-mon.txt", "tr-large-mon.txt", "tw-large-mon.txt",
          "tr-small-split.txt", "tw-small-split.txt", "tr-med-split.txt", "tw-med-split.txt", "tr-large-split.txt", "tw-large-split.txt"]

for label in labels:
    sizestr = "small" if "small" in label else ("med" if "med" in label else "large")
    action = "write" if 'w' in label else "read"
    plot_transfer_time(label, sizestr, action)
#
plot_three_mins(labels[0::6], "small", "read", 100)
plot_three_mins(labels[1::6], "small", "write", 100)
plot_three_mins(labels[2::6], "med", "read", 100)
plot_three_mins(labels[3::6], "med", "write", 100)
plot_three_mins(labels[4::6], "large", "read", 100)
plot_three_mins(labels[5::6], "large", "write", 100)

# plot_histograms(labels[0::6], "small", "read")
# plot_histograms(labels[1::6], "small", "write")
# plot_histograms(labels[2::6], "med", "read")
# plot_histograms(labels[3::6], "med", "write")
# plot_histograms(labels[4::6], "large", "read")
# plot_histograms(labels[5::6], "large", "write")

# for label in labels:
#     sizestr = re.search('(.*)\-(.*)(\-(.*))?.txt', label).group(1)[3:]
#     action = "read" if 'r' in label else "write"
#     plot_histogram(label, sizestr, action)
