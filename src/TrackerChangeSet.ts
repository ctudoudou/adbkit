import Device from './Device';

export default interface TrackerChangeSet {
  removed: Device[];
  changed: Device[];
  added: Device[];
}
