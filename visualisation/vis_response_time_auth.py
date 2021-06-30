import matplotlib.pyplot as plt
import numpy as np
import re
import statistics as stats

auth = "D:\\Uni\\Thesis\\Code\\new\\stmonitor\\fixedauthlogs\\time\\"
splitauth = "D:\\Uni\\Thesis\\Code\\new\\stmonitor\\fixedauthlogs\\time\\"


def plot_response_time(filename):
    filepath = (splitauth if "split" in filename else auth) + filename
    file = open(filepath, 'r')
    data = [float(t) for t in file.read().split(',')[:-1]]
    file.close()

    datatrimmed = data
    # for i in data:
    #     if i < 0.8:
    #         datatrimmed.append(i)

    colour = 'g' if "split" in filename else ('r' if "dyn" in filename else 'c')
    name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "dyn" in filename else 'Control')
    plt.plot(np.arange(1, len(datatrimmed)+1, 1), datatrimmed, colour, label=name + "; Min: " + str(round(min(datatrimmed), 6)))
    plt.xlabel('Iterations')
    plt.ylabel("Response Time")
    plt.title("Response time of Auth over 20000 iterations")
    plt.legend()
    plt.savefig("single-" + filename.split('-')[1] + "-auth.png")
    plt.show()


def plot_minimums(filename, step):
    filepath = (splitauth if "split" in filename else auth) + filename
    file = open(filepath, 'r')
    data = [float(t) for t in file.read().split(',')[:-1]]
    file.close()
    
    mins = [min(data[i*step:(i+1)*step]) for i in range(int(len(data)/step))]

    colour = 'g' if "split" in filename else ('r' if "dyn" in filename else 'c')
    name = 'Sequence Recogniser' if "split" in filename else ('Partial Identity' if "dyn" in filename else 'Control')
    plt.plot(np.arange(1, len(data)+1, step), mins, colour, label=name + "; Min: " + str(round(min(mins), 6)))
    plt.xlabel('Iterations')
    plt.ylabel("Response Time")
    plt.title("Response time of Auth over 20000 iterations")
    plt.legend()
    plt.show()


def plot_three(filenames):
    for filename in filenames:
        filepath = (splitauth if "split" in filename else auth) + filename
        file = open(filepath, 'r')
        data = [float(t) for t in file.read().split(',')[:-1]]
        file.close()

        # mins = [min(data[i*step:(i+1)*step]) for i in range(int(len(data)/step))]

        colour = 'g' if "split" in filename else ('r' if "dyn" in filename else 'c')
        name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "dyn" in filename else 'Control')
        plt.plot(np.arange(1, len(data)+1, 1), data, colour, label=name + "; Min: " + str(round(min(data), 6)))
    plt.xlabel('Iterations')
    plt.ylabel("Response Time")
    plt.title("Response time of Auth over 20000 iterations")
    plt.legend()
    plt.show()


def plot_three_mins(filenames, step):
    for filename in filenames:
        filepath = (splitauth if "split" in filename else auth) + filename
        file = open(filepath, 'r')
        data = [float(t) for t in file.read().split(',')[:-1]]
        file.close()

        mins = [min(data[i*step:(i+1)*step]) for i in range(int(len(data)/step))]

        colour = 'g' if "split" in filename else ('r' if "dyn" in filename else 'c')
        name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "dyn" in filename else 'Control')
        plt.plot(np.arange(1, len(data)+1, step), mins, colour, label=name + "; Min: " + str(round(min(mins), 6)))
    plt.xlabel('Iterations')
    plt.ylabel("Response Time")
    plt.title("Response time of Auth over 20000 iterations")
    plt.legend()
    plt.savefig("mins-auth.png")
    plt.show()


def plot_histogram(filename):
    filepath = (splitauth if "split" in filename else auth) + filename
    file = open(filepath, 'r')
    data = [float(t) for t in file.read().split(',')[:-1]]
    file.close()

    # mins = [min(data[i * step:(i + 1) * step]) for i in range(int(len(data) / step))]

    colour = 'g' if "split" in filename else ('r' if "dyn" in filename else 'c')
    name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "dyn" in filename else 'Control')
    bins = np.linspace(0, 0.004, 100)

    plt.hist(data, bins, alpha=0.5, label=name, color=colour)
    plt.xlabel('Response Time (s)')
    plt.title("Response time of Auth over 20000 iterations")
    plt.legend()
    plt.show()


def plot_histograms(filenames):
    bins = np.linspace(0, 0.006, 100)
    for filename in filenames:
        filepath = (splitauth if "split" in filename else auth) + filename
        file = open(filepath, 'r')
        data = [float(t) for t in file.read().split(',')[:-1]]
        file.close()

        # mins = [min(data[i * step:(i + 1) * step]) for i in range(int(len(data) / step))]

        colour = 'g' if "split" in filename else ('r' if "dyn" in filename else 'c')
        name = 'Sequence Recogniser' if "split" in filename else ('Partial-Identity' if "dyn" in filename else 'Control')

        plt.hist(data, bins, alpha=0.5, label=name + "; Median: " + str(round(stats.median(data), 6)), color=colour)
    plt.xlabel('Response Time (s)')
    plt.ylabel('Frequency')
    plt.title("Response time of Auth over 20000 iterations")
    plt.legend()
    plt.savefig("hist-auth.png")
    plt.show()


labels = ["20000-rt-1.txt", "20000-dyn-rt-1.txt", "20000-split-rt-1.txt"]

# for label in labels:
#     sizestr = "small" if "small" in label else ("med" if "med" in label else "large")
#     action = "write" if 'w' in label else "read"
#     plot_response_time(label)
#
# plot_three(labels)
plot_three_mins(labels, 100)
#
plot_histograms(labels)
# total = 0
# rtime = open(splitauth + labels[2], 'r')
# vals = [float(t) for t in rtime.read().split(',')[:-1]]
# rtime.close()
# for i in vals:
#     if i > 1:
#         total += 1

# print("Outliers: ", total)

# for label in labels:
#     sizestr = re.search('(.*)\-(.*)(\-(.*))?.txt', label).group(1)[3:]
#     action = "read" if 'r' in label else "write"
#     plot_histogram(label)
