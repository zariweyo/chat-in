enum ENV { prod, test }

class ConfigRepository {
        final ENV enviroment;

        ConfigRepository({
                required this.enviroment
        });
}