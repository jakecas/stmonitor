import matplotlib.pyplot as plt

ftppath = "D:\\Uni\\Thesis\\Code\\new\\stmonitor\\fixedauthlogs\\"
splitftppath = "D:\\Uni\\Thesis\\Code\\new\\stmonitor\\fixedauthlogs\\"
labels = ["100", "200", "300", "400", "500", "600", "700", "800", "900", "1000", "1500",
          "2000", "2500", "3000", "3500", "4000", "4500"
          , "5000", "5500", "6000", "6500", "7000", "7500", "8000", "8500", "9000", "9500", "10000"]
          #  "10500", "11000", "11500", "12000", "12500", "13000", "13500", "14000", "14500", "15000",
          # "16000", "17000", "18000", "19000", "20000"]


def split_file(file):
    return [x.split(',') for x in file.split('\n')]


def get_time_avg(data):
    return (float(data[0][0])
            + float(data[1][0])
            + float(data[2][0])) / 3


def get_mem_avg_of_file(data):
    return (int(data[0][2])
            + int(data[1][2])
            + int(data[2][2])) / 3.0


def print_mem_avg_of_data(data):
    print("Average memory: ", sum(data[9:])/len(data[9:]))


def get_mem_avg_from_file(filename):
    f = open(filename, "r")
    data = split_file(f.read())
    f.close()
    return get_mem_avg_of_file(data)


def get_control_vals(label, suffixC, suffixS, time_vals, mem_vals):
    f = open(ftppath + label + suffixC, "r")
    data = split_file(f.read())
    time_vals.append(get_time_avg(data))
    mem_vals.append(get_mem_avg_of_file(data))
    f.close()

    mem_vals[i] += (get_mem_avg_from_file(ftppath + label + suffixS))


def get_dyn_vals(label, suffixC, suffixS, suffixM, time_vals, mem_vals):
    f = open(ftppath + label + suffixC, "r")
    data = split_file(f.read())
    time_vals.append(get_time_avg(data))
    mem_vals.append(get_mem_avg_of_file(data))
    f.close()

    mem_vals[i] += (get_mem_avg_from_file(ftppath + label + suffixS))

    mem_vals[i] += (get_mem_avg_from_file(ftppath + label + suffixM))


def get_split_vals(label, suffixC, suffixS, suffixCM, suffixSM, time_vals, mem_vals):
    f = open(splitftppath + label + suffixC, "r")
    data = split_file(f.read())
    time_vals.append(get_time_avg(data))
    mem_vals.append(get_mem_avg_of_file(data))
    f.close()

    mem_vals[i] += (get_mem_avg_from_file(splitftppath + label + suffixS))

    mem_vals[i] += (get_mem_avg_from_file(splitftppath + label + suffixSM))

    mem_vals[i] += (get_mem_avg_from_file(splitftppath + label + suffixCM))


client_exectime_vals = []
dyn_client_exectime_vals = []
split_client_exectime_vals = []

total_mem_vals = []
dyn_total_mem_vals = []
split_total_mem_vals = []

for i in range(len(labels)):
    label = labels[i]

    get_control_vals(label, "-auth-client.txt", "-auth-server.txt",
                     client_exectime_vals, total_mem_vals)

    get_dyn_vals(label, "-auth-dyn-client.txt", "-auth-dyn-server.txt", "-auth-dyn-mon.txt",
                 dyn_client_exectime_vals, dyn_total_mem_vals)

    get_split_vals(label, "-auth-split-client.txt", "-auth-split-cmon.txt", "-auth-split-smon.txt",
                   "-auth-split-cmon.txt", split_client_exectime_vals, split_total_mem_vals)

x_axis = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1500,
          2000, 2500, 3000, 3500, 4000, 4500,
          5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000]
          #  10500, 11000, 11500, 12000, 12500, 13000, 13500, 14000, 14500, 15000,
          # 16000, 17000, 18000, 19000, 20000]


def plot_graphs(title, ylabel, controltime, dyntime, splittime, adjust=False, param=0):
    plt.plot(x_axis, controltime, 'c', label="Control")
    plt.plot(x_axis, dyntime, 'r', label="Partial-Identity")
    plt.plot(x_axis, splittime, 'g', label="Sequence Recogniser")
    plt.xlabel('Iterations')
    plt.ylabel(ylabel)
    plt.title(title)
    plt.legend()
    action = "exec" if "Exec" in title else "mem"
    plt.savefig("auth-" + action)
    plt.show()


plot_graphs("Client Execution Time while Performing Auths", 'Execution Time (s)',
            client_exectime_vals,
            dyn_client_exectime_vals,
            split_client_exectime_vals)
#
# responsetimes = [float(t) for t in open("D:\\Uni\\Thesis\\Code\\new\\stmonitor\\fixedauthlogs\\time\\20000-split-rt-1.txt", 'r').read().split(',')[:-1]]
# split_client_exectime_vals_pruned = []
# for i in range(len(x_axis)):
#     outliers = [x for x in responsetimes[:x_axis[i]] if x > 0.1]
#     print(len(outliers) / x_axis[i])
#     print(split_client_exectime_vals[i], " - outliers: ", sum(outliers))
#     split_client_exectime_vals_pruned.append(split_client_exectime_vals[i] - sum(outliers))
#
# plot_graphs("Client Execution Time while Performing Auths", 'Execution Time (s)',
#             client_exectime_vals,
#             dyn_client_exectime_vals,
#             split_client_exectime_vals_pruned)

# plot_graphs("Maximum Memory Usage while Performing Auths", 'Memory (KB)',
#             total_mem_vals,
#             dyn_total_mem_vals,
#             split_total_mem_vals)

print_mem_avg_of_data(dyn_total_mem_vals)
print_mem_avg_of_data(split_total_mem_vals)
