import tensorflow as tf
import numpy as np


def startup():
    print("Num GPUs Available: ", len(tf.config.experimental.list_physical_devices('GPU')))

    with tf.device('/GPU:0'):
        num_samples = 10000
        input_dim = 100
        output_dim = 10

        x_train = np.random.random((num_samples, input_dim)).astype(np.float32)
        y_train = np.random.random((num_samples, output_dim)).astype(np.float32)

        model = tf.keras.Sequential([
            tf.keras.layers.Dense(512, activation='relu', input_shape=(input_dim,)),
            tf.keras.layers.Dense(512, activation='relu'),
            tf.keras.layers.Dense(output_dim)
        ])

        model.compile(optimizer='adam', loss='mse')

        model.fit(x_train, y_train, epochs=100, batch_size=32)

        loss = model.evaluate(x_train, y_train, batch_size=32)
        print(f'Loss: {loss}')


if __name__ == '__main__':
    startup()
