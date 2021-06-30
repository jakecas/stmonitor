import matplotlib.pyplot as plt
import numpy as np
import numpy.polynomial.polynomial as poly

ftppath = "D:\\Uni\\Thesis\\Code\\new\\stmonitor\\remote_logs\\"
splitftppath = "D:\\Uni\\Thesis\\Code\\new\\stmonitor\\remote_logs\\split\\"
labels = ["100", "200", "300", "400", "500", "600", "700", "800", "900", "1000", "1500",
          "2000", "2500", "3000", "3500", "4000", "4500", "5000", "5500", "6000", "6500",
          "7000", "7500", "8000", "8500", "9000", "9500", "10000"]
          # , "10500", "11000", "11500", "12000", "12500", "13000", "13500", "14000", "14500", "15000"]


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


def get_mem_avg_from_file(filename):
    f = open(filename, "r")
    data = split_file(f.read())
    f.close()
    return get_mem_avg_of_file(data)


def print_mem_avg_of_data(data):
    print("Average memory: ", sum(data[9:])/len(data[9:]))


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


small_r_client_exectime_vals = []
small_r_dyn_client_exectime_vals = []
small_r_split_client_exectime_vals = []
small_w_client_exectime_vals = []
small_w_dyn_client_exectime_vals = []
small_w_split_client_exectime_vals = []
small_rw_client_exectime_vals = []
small_rw_dyn_client_exectime_vals = []
small_rw_split_client_exectime_vals = []
medium_r_client_exectime_vals = []
medium_r_dyn_client_exectime_vals = []
medium_r_split_client_exectime_vals = []
medium_w_client_exectime_vals = []
medium_w_dyn_client_exectime_vals = []
medium_w_split_client_exectime_vals = []
medium_rw_client_exectime_vals = []
medium_rw_dyn_client_exectime_vals = []
medium_rw_split_client_exectime_vals = []
large_r_client_exectime_vals = []
large_r_dyn_client_exectime_vals = []
large_r_split_client_exectime_vals = []
large_w_client_exectime_vals = []
large_w_dyn_client_exectime_vals = []
large_w_split_client_exectime_vals = []
large_rw_client_exectime_vals = []
large_rw_dyn_client_exectime_vals = []
large_rw_split_client_exectime_vals = []

small_r_total_mem_vals = []
small_r_dyn_total_mem_vals = []
small_r_split_total_mem_vals = []
small_w_total_mem_vals = []
small_w_dyn_total_mem_vals = []
small_w_split_total_mem_vals = []
small_rw_total_mem_vals = []
small_rw_dyn_total_mem_vals = []
small_rw_split_total_mem_vals = []
medium_r_total_mem_vals = []
medium_r_dyn_total_mem_vals = []
medium_r_split_total_mem_vals = []
medium_w_total_mem_vals = []
medium_w_dyn_total_mem_vals = []
medium_w_split_total_mem_vals = []
medium_rw_total_mem_vals = []
medium_rw_dyn_total_mem_vals = []
medium_rw_split_total_mem_vals = []
large_r_total_mem_vals = []
large_r_dyn_total_mem_vals = []
large_r_split_total_mem_vals = []
large_w_total_mem_vals = []
large_w_dyn_total_mem_vals = []
large_w_split_total_mem_vals = []
large_rw_total_mem_vals = []
large_rw_dyn_total_mem_vals = []
large_rw_split_total_mem_vals = []

for i in range(len(labels)):
    label = labels[i]

    # Small Read
    get_control_vals(label, "-small-r-client.txt", "-small-r-server.txt",
                     small_r_client_exectime_vals, small_r_total_mem_vals)

    get_dyn_vals(label, "-small-r-dyn-client.txt", "-small-r-dyn-server.txt", "-small-r-dyn-mon.txt",
                 small_r_dyn_client_exectime_vals, small_r_dyn_total_mem_vals)

    get_split_vals(label, "-small-r-dyn-client.txt", "-small-r-dyn-client.txt", "-small-r-dyn-smon.txt",
                   "-small-r-dyn-cmon.txt", small_r_split_client_exectime_vals, small_r_split_total_mem_vals)

    # Small Write
    get_control_vals(label, "-small-w-client.txt", "-small-w-server.txt",
                     small_w_client_exectime_vals, small_w_total_mem_vals)

    get_dyn_vals(label, "-small-w-dyn-client.txt", "-small-w-dyn-server.txt", "-small-w-dyn-mon.txt",
                 small_w_dyn_client_exectime_vals, small_w_dyn_total_mem_vals)

    get_split_vals(label, "-small-w-dyn-client.txt", "-small-w-dyn-client.txt", "-small-w-dyn-smon.txt",
                   "-small-w-dyn-cmon.txt", small_w_split_client_exectime_vals, small_w_split_total_mem_vals)

    # Small Read/Write
    get_control_vals(label, "-small-rw-client.txt", "-small-rw-server.txt",
                     small_rw_client_exectime_vals, small_rw_total_mem_vals)

    get_dyn_vals(label, "-small-rw-dyn-client.txt", "-small-rw-dyn-server.txt", "-small-rw-dyn-mon.txt",
                 small_rw_dyn_client_exectime_vals, small_rw_dyn_total_mem_vals)

    get_split_vals(label, "-small-rw-dyn-client.txt", "-small-rw-dyn-client.txt", "-small-rw-dyn-smon.txt",
                   "-small-rw-dyn-cmon.txt", small_rw_split_client_exectime_vals, small_rw_split_total_mem_vals)

    # Medium Read
    get_control_vals(label, "-medium-r-client.txt", "-medium-r-server.txt",
                     medium_r_client_exectime_vals, medium_r_total_mem_vals)

    get_dyn_vals(label, "-medium-r-dyn-client.txt", "-medium-r-dyn-server.txt", "-medium-r-dyn-mon.txt",
                 medium_r_dyn_client_exectime_vals, medium_r_dyn_total_mem_vals)

    get_split_vals(label, "-medium-r-dyn-client.txt", "-medium-r-dyn-client.txt", "-medium-r-dyn-smon.txt",
                   "-medium-w-dyn-cmon.txt", medium_r_split_client_exectime_vals, medium_r_split_total_mem_vals)

    # Medium Wri
    get_control_vals(label, "-medium-w-client.txt", "-medium-w-server.txt",
                     medium_w_client_exectime_vals, medium_w_total_mem_vals)

    get_dyn_vals(label, "-medium-w-dyn-client.txt", "-medium-w-dyn-server.txt", "-medium-w-dyn-mon.txt",
                 medium_w_dyn_client_exectime_vals, medium_w_dyn_total_mem_vals)

    get_split_vals(label, "-medium-w-dyn-client.txt", "-medium-w-dyn-client.txt", "-medium-w-dyn-smon.txt",
                   "-medium-w-dyn-cmon.txt", medium_w_split_client_exectime_vals, medium_w_split_total_mem_vals)

    # Medium Read/Write
    get_control_vals(label, "-medium-rw-client.txt", "-medium-rw-server.txt",
                     medium_rw_client_exectime_vals, medium_rw_total_mem_vals)

    get_dyn_vals(label, "-medium-rw-dyn-client.txt", "-medium-rw-dyn-server.txt", "-medium-rw-dyn-mon.txt",
                 medium_rw_dyn_client_exectime_vals, medium_rw_dyn_total_mem_vals)

    get_split_vals(label, "-medium-rw-dyn-client.txt", "-medium-rw-dyn-client.txt", "-medium-rw-dyn-smon.txt",
                   "-medium-rw-dyn-cmon.txt", medium_rw_split_client_exectime_vals, medium_rw_split_total_mem_vals)

    # Large Read
    get_control_vals(label, "-large-r-client.txt", "-large-r-server.txt",
                     large_r_client_exectime_vals, large_r_total_mem_vals)

    get_dyn_vals(label, "-large-r-dyn-client.txt", "-large-r-dyn-server.txt", "-large-r-dyn-mon.txt",
                 large_r_dyn_client_exectime_vals, large_r_dyn_total_mem_vals)

    get_split_vals(label, "-large-r-dyn-client.txt", "-large-r-dyn-client.txt", "-large-r-dyn-smon.txt",
                   "-large-r-dyn-cmon.txt", large_r_split_client_exectime_vals, large_r_split_total_mem_vals)

    # Large Write
    get_control_vals(label, "-large-w-client.txt", "-large-w-server.txt",
                     large_w_client_exectime_vals, large_w_total_mem_vals)

    get_dyn_vals(label, "-large-w-dyn-client.txt", "-large-w-dyn-server.txt", "-large-w-dyn-mon.txt",
                 large_w_dyn_client_exectime_vals, large_w_dyn_total_mem_vals)

    get_split_vals(label, "-large-w-dyn-client.txt", "-large-w-dyn-client.txt", "-large-w-dyn-smon.txt",
                   "-large-w-dyn-cmon.txt", large_w_split_client_exectime_vals, large_w_split_total_mem_vals)

    # Large Read/Write
    get_control_vals(label, "-large-rw-client.txt", "-large-rw-server.txt",
                     large_rw_client_exectime_vals, large_rw_total_mem_vals)

    get_dyn_vals(label, "-large-rw-dyn-client.txt", "-large-rw-dyn-server.txt", "-large-rw-dyn-mon.txt",
                 large_rw_dyn_client_exectime_vals, large_rw_dyn_total_mem_vals)

    get_split_vals(label, "-large-rw-dyn-client.txt", "-large-rw-dyn-client.txt", "-large-rw-dyn-smon.txt",
                   "-large-rw-dyn-cmon.txt", large_rw_split_client_exectime_vals, large_rw_split_total_mem_vals)

x_axis = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1500,
          2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500,
          7000, 7500, 8000, 8500, 9000, 9500, 10000]
          # , 10500, 11000, 11500, 12000, 12500, 13000, 13500, 14000, 14500, 15000]


def plot_graphs(title, ylabel, readC, readD, readS, writeC, writeD, writeS, rwC, rwD, rwS):
    plt.plot(x_axis, readC, 'c', label="Control-r")
    # print("RDC grad:", poly.Polynomial.fit(x_axis, readC, 1))
    plt.plot(x_axis, readD, 'r', label="Partial Identity-r")
    # print("RDD grad:", poly.Polynomial.fit(x_axis, readD, 1))
    plt.plot(x_axis, readS, 'g', label="Sequence Recogniser-r")
    # print("RDS grad:", poly.Polynomial.fit(x_axis, readS, 1))
    plt.plot(x_axis, writeC, 'c--', label="Control-w")
    # print("WRC grad:", poly.Polynomial.fit(x_axis, writeC, 1))
    plt.plot(x_axis, writeD, 'r--', label="Partial Identity-w")
    # print("WRD grad:", poly.Polynomial.fit(x_axis, writeD, 1))
    plt.plot(x_axis, writeS, 'g--', label="Sequence Recogniser-w")
    # print("WRS grad:", poly.Polynomial.fit(x_axis, writeS, 1))
    plt.plot(x_axis, rwC, 'c:', label="Control-rw")
    # print("RWC grad:", poly.Polynomial.fit(x_axis, rwC, 1))
    plt.plot(x_axis, rwD, 'r:', label="Partial Identity-rw")
    # print("RWD grad:", poly.Polynomial.fit(x_axis, rwD, 1))
    plt.plot(x_axis, rwS, 'g:', label="Sequence Recogniser-rw")
    # print("RWS grad:", poly.Polynomial.fit(x_axis, rwS, 1))
    plt.xlabel('Iterations')
    plt.ylabel(ylabel)
    plt.title(title)
    plt.legend()
    action = "exec" if "Exec" in title else "mem"
    sizestr = "small" if "Small" in title else ("med" if "Med" in title else "large")
    plt.savefig(action+"-"+sizestr)
    plt.show()


plot_graphs("Client Execution Time of Reading/Writing Small Files", 'Execution Time (s)',
            small_r_client_exectime_vals,
            small_r_dyn_client_exectime_vals,
            small_r_split_client_exectime_vals,
            small_w_client_exectime_vals,
            small_w_dyn_client_exectime_vals,
            small_w_split_client_exectime_vals,
            small_rw_client_exectime_vals,
            small_rw_dyn_client_exectime_vals,
            small_rw_split_client_exectime_vals)

plot_graphs("Client Execution Time of Reading/Writing Medium Files", 'Execution Time (s)',
            medium_r_client_exectime_vals,
            medium_r_dyn_client_exectime_vals,
            medium_r_split_client_exectime_vals,
            medium_w_client_exectime_vals,
            medium_w_dyn_client_exectime_vals,
            medium_w_split_client_exectime_vals,
            medium_rw_client_exectime_vals,
            medium_rw_dyn_client_exectime_vals,
            medium_rw_split_client_exectime_vals)

plot_graphs("Client Execution Time of Reading/Writing Large Files", 'Execution Time (s)',
            large_r_client_exectime_vals,
            large_r_dyn_client_exectime_vals,
            large_r_split_client_exectime_vals,
            large_w_client_exectime_vals,
            large_w_dyn_client_exectime_vals,
            large_w_split_client_exectime_vals,
            large_rw_client_exectime_vals,
            large_rw_dyn_client_exectime_vals,
            large_rw_split_client_exectime_vals)

plot_graphs("Maximum Memory Usage while Reading/Writing Small Files", 'Memory (KB)',
            small_r_total_mem_vals,
            small_r_dyn_total_mem_vals,
            small_r_split_total_mem_vals,
            small_w_total_mem_vals,
            small_w_dyn_total_mem_vals,
            small_w_split_total_mem_vals,
            small_rw_total_mem_vals,
            small_rw_dyn_total_mem_vals,
            small_rw_split_total_mem_vals)

# print_mem_avg_of_data(small_rw_dyn_total_mem_vals)
# print_mem_avg_of_data(small_rw_split_total_mem_vals)

plot_graphs("Maximum Memory Usage while Reading/Writing Medium Files", 'Memory (KB)',
            medium_r_total_mem_vals,
            medium_r_dyn_total_mem_vals,
            medium_r_split_total_mem_vals,
            medium_w_total_mem_vals,
            medium_w_dyn_total_mem_vals,
            medium_w_split_total_mem_vals,
            medium_rw_total_mem_vals,
            medium_rw_dyn_total_mem_vals,
            medium_rw_split_total_mem_vals)

plot_graphs("Maximum Memory Usage while Reading/Writing Large Files", 'Memory (KB)',
            large_r_total_mem_vals,
            large_r_dyn_total_mem_vals,
            large_r_split_total_mem_vals,
            large_w_total_mem_vals,
            large_w_dyn_total_mem_vals,
            large_w_split_total_mem_vals,
            large_rw_total_mem_vals,
            large_rw_dyn_total_mem_vals,
            large_rw_split_total_mem_vals)
