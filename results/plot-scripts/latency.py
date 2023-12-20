import matplotlib.pyplot as plt
import numpy as np

# Data
send_rate = [50, 90, 150, 190, 270, 360, 420, 480]
throughput_BTS1 = [48, 88, 147, 181, 252, 278, 309, 286]
latency_BTS1 = [0.61, 0.73, 0.77, 0.97, 1.15, 2.73, 2.92, 3.33]

throughput_BTS3 = [46, 78, 141, 178, 241, 253, 276, 241]
latency_BTS3 = [1.78, 2.02, 2.31, 2.6, 3.2, 4.67, 4.84, 6.7]

throughput_BTS5 = [42, 72, 135, 162, 205, 211, 228, 203]
latency_BTS5 = [2.94, 3.12, 3.7, 4.12, 5.71, 6.63, 7.33, 9.58]

# Plotting
fig, ax1 = plt.subplots(figsize=(10, 6))

error_tps1 = [0.05 * val for val in throughput_BTS1]
error_tps3 = [0.05 * val for val in throughput_BTS3]
error_tps5 = [0.05 * val for val in throughput_BTS5]

ax1.set_xlabel('Send Rate(TPS)', fontdict={"size": 14})
ax1.set_ylabel('Throughput(TPS)', color='black', fontdict={"size": 14})

bar_width = 0.15
index = np.arange(len(send_rate))
x_values = range(len(send_rate))

colors = {
    'Throughput-BT1s': '#1f77b4',
    'Throughput-BT3s': '#ff4c4c',
    'Throughput-BT5s': '#4ca64c'
}

ax1.errorbar(index - bar_width, throughput_BTS1, yerr=error_tps1, fmt='+', color='black')
ax1.errorbar(index, throughput_BTS3, yerr=error_tps3, fmt='+', color='black')
ax1.errorbar(index + bar_width, throughput_BTS5, yerr=error_tps5, fmt='+', color='black')

ax1.bar(index - bar_width, throughput_BTS1, color=colors['Throughput-BT1s'], alpha=1, width=bar_width, label='Throughput-BT1s')
ax1.bar(index, throughput_BTS3, color=colors['Throughput-BT3s'], alpha=1, width=bar_width, label='Throughput-BT3s')
ax1.bar(index + bar_width, throughput_BTS5, color=colors['Throughput-BT5s'], alpha=1, width=bar_width, label='Throughput-BT5s')

ax1.tick_params(axis='y', labelcolor='black')

ax2 = ax1.twinx()

error_time1 = [0.05 * val for val in latency_BTS1]
error_time3 = [0.05 * val for val in latency_BTS3]
error_time5 = [0.05 * val for val in latency_BTS5]

ax2.set_ylabel('Latency(s)', color='black', fontdict={"size": 14})
ax2.errorbar(x_values, latency_BTS1, yerr=error_time1, fmt='*', color='black')
ax2.errorbar(x_values, latency_BTS3, yerr=error_time3, fmt='*', color='black')
ax2.errorbar(x_values, latency_BTS5, yerr=error_time5, fmt='*', color='black')
ax2.plot(x_values, latency_BTS1, color='tab:orange', alpha=0.5, label='Latency-BT1s')
ax2.plot(x_values, latency_BTS3, color='tab:purple', alpha=0.5, label='Latency-BT3s')
ax2.plot(x_values, latency_BTS5, color='tab:brown', alpha=0.5, label='Latency-BT5s')
ax2.tick_params(axis='y', labelcolor='black')

ax1.set_xticks(x_values)
ax1.set_xticklabels(send_rate)

plt.show()
