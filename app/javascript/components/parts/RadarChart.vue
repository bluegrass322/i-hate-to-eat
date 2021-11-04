<script>
import { Radar, mixins } from 'vue-chartjs';
const { reactiveProp } = mixins;

export default {
  extends: Radar,
  mixins: [reactiveProp],
  props: {
    options: {
      type: Object,
      default: null,
    },
  },
  mounted() {
    this.renderChart(this.chartData, this.options);
  },
};
</script>